//
//  GHSFetchUserRepositories.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 21/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSFetchUserRepositories.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSUserRepositoriesNetwork.h"

@implementation GHSFetchUserRepositories

- (instancetype)initWithUserRepositoriesNetwork:(GHSUserRepositoriesNetwork *)userRepositoriesNetwork
{
    self = [super init];
    if (self)
    {
        _userRepositoriesNetwork = userRepositoriesNetwork;
    }
    return self;
}

- (RACSignal *)fetchUserRepositoriesWithRefreshSignal:(RACSignal *)refreshSignal
{
    refreshSignal = [self sanitizeRefreshSignal:refreshSignal];
    RACSignal *fireOnceSignal = [RACSignal return:[RACSignal empty]];
    
    // We want to fetch at least once, then each time refreshSignal sends next
    RACSignal *fetchSignal = [RACSignal merge:@[fireOnceSignal, refreshSignal]];
    
    GHSUserRepositoriesNetwork *userRepositoriesNetwork = self.userRepositoriesNetwork;
    RACSignal *networkSignal = [[fetchSignal
                                 map:^(id _) {
                                     return [userRepositoriesNetwork fetchUserRepositories];
                                 }]
                                 switchToLatest];
    return networkSignal;
}

- (RACSignal *)sanitizeRefreshSignal:(RACSignal *)refreshSignal
{
    if (!refreshSignal)
    {
        refreshSignal = [RACSignal empty];
    }
    return refreshSignal;
}

@end
