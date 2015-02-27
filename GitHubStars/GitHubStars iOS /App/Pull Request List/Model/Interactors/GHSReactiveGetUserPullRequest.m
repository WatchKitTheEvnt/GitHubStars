//
//  GHSReactiveGetUserPullRequest.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 25/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSReactiveGetUserPullRequest.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "GHSFetchUserPullRequest.h"

@implementation GHSReactiveGetUserPullRequest

- (instancetype)initWithFetchUserPullRequest:(GHSFetchUserPullRequest *)fetchUserPullRequest
                  userPullRequestFileStorage:(id<GHSPullRequestAsyncStorage>)userPullRequestFileStorage
{
    self = [super init];
    if (self)
    {
        _fetchUserPullRequest = fetchUserPullRequest;
        _userPullRequestFileStorage = userPullRequestFileStorage;
    }
    return self;
}

- (RACSignal *)getUserPullRequestSkippingCacheWithRefreshSignal:(RACSignal *)refreshSignal
                                              forRepositoryName:(NSString *)repositoryName
                                                          owner:(NSString *)owner
{
    id<GHSPullRequestAsyncStorage> userPullRequestFileStorage = self.userPullRequestFileStorage;

    RACSignal *fetchSignal = [[self.fetchUserPullRequest fetchUserPullRequestWithRefreshSignal:refreshSignal forRepositoryName:repositoryName owner:owner]
                              doNext:^(GHSUserPullRequest *fetchedUserPullRequest) {
                                  // persist fetched pull request as a side effect of fetch signal
                                  [userPullRequestFileStorage saveUserPullRequest:fetchedUserPullRequest withCompletionHandler:nil];
                              }];
    return fetchSignal;
}

@end
