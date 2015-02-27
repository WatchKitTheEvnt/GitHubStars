//
//  GHSReactiveUserRepositories.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSReactiveGetUserRepositories.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSFetchUserRepositories.h"
#import "GHSLoadUserRepositories.h"

@implementation GHSReactiveGetUserRepositories

- (instancetype)initWithFetchUserRepositories:(GHSFetchUserRepositories *)fetchUserRepositories
                         loadUserRepositories:(GHSLoadUserRepositories *)loadUserRepositories
                      userRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage
{
    self = [super init];
    if (self)
    {
        _fetchUserRepositories = fetchUserRepositories;
        _loadUserRepositories = loadUserRepositories;
        _userRepositoriesStorage = userRepositoriesStorage;
    }
    return self;
}

- (RACSignal *)getUserRepositoriesWithRefreshSignal:(RACSignal *)refreshSignal
{
    RACSignal *loadSignal = [self loadSignal];
    RACSignal *fetchSignal = [self fetchSignalWithRefreshSignal:refreshSignal];

    return [loadSignal takeUntilReplacement:fetchSignal];
}

- (RACSignal *)getUserRepositoriesSkippingCacheWithRefreshSignal:(RACSignal *)refreshSignal
{
    return [self fetchSignalWithRefreshSignal:refreshSignal];
}

#pragma mark - Private

- (RACSignal *)loadSignal
{
    return [self.loadUserRepositories loadUserRepositoriesSignal];
}

- (RACSignal *)fetchSignalWithRefreshSignal:(RACSignal *)refreshSignal
{
    GHSUserRepositoriesStorage *userRepositoriesStorage = self.userRepositoriesStorage;
    
    RACSignal *fetchSignal = [[self.fetchUserRepositories fetchUserRepositoriesWithRefreshSignal:refreshSignal]
                              doNext:^(GHSUserRepositories *fetchedUserRepositories) {
                                  // persist fetched repos as a side effect of fetch signal
                                  [userRepositoriesStorage saveUserRepositories:fetchedUserRepositories];
                              }];
    
    return fetchSignal;
}

@end
