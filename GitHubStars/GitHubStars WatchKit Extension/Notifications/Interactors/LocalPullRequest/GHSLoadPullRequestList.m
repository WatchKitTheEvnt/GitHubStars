//
//  GHSGetUserPullRequestList.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSLoadPullRequestList.h"

@implementation GHSLoadPullRequestList

- (instancetype)initWithPullRequestSyncStorage:(id<GHSPullRequestSyncStorage>)syncStorage asyncStorage:(id<GHSPullRequestAsyncStorage>)asyncStorage
{
    self = [super init];
    if (self)
    {
        _syncStorage = syncStorage;
        _asyncStorage = asyncStorage;
    }
    return self;
}

- (GHSUserPullRequest *)loadUserPullRequest
{
    return [self.syncStorage loadUserPullRequest];
}

- (void)loadUserPullRequestWithCompletion:(void (^)(GHSUserPullRequest *pullRequest))completionHandler
{
    [self.asyncStorage loadUserPullRequestWithCompletionHandler:^(GHSUserPullRequest *pullRequest, NSError *error) {
        completionHandler(pullRequest);
    }];
}

@end
