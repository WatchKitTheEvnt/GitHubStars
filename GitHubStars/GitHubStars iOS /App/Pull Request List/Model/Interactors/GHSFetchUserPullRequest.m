//
//  GHSFecthUserPullRequest.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 24/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSFetchUserPullRequest.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSUserPullRequestNetwork.h"


@implementation GHSFetchUserPullRequest

- (instancetype)initWithUserPullRequestNetwork:(GHSUserPullRequestNetwork *)userPullRequestNetwork
{
    self = [super init];
    if (self)
    {
        _userPullRequestNetwork = userPullRequestNetwork;
    }
    return self;
}

- (RACSignal *)fetchUserPullRequestWithRefreshSignal:(RACSignal *)refreshSignal
                                   forRepositoryName:(NSString *)repositoryName
                                               owner:(NSString *)owner
{
    refreshSignal = [self sanitizeRefreshSignal:refreshSignal];
    RACSignal *fireOnceSignal = [RACSignal return:[RACSignal empty]];
    
    // We want to fetch at least once, then each time refreshSignal sends next
    RACSignal *fetchSignal = [RACSignal merge:@[fireOnceSignal, refreshSignal]];
    
    GHSUserPullRequestNetwork *userPullRequestNetwork = self.userPullRequestNetwork;
    RACSignal *networkSignal = [[fetchSignal
                                 map:^(id _) {
                                     return [userPullRequestNetwork fetchUserPullRequestForRepositoryName:repositoryName owner:owner];
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
