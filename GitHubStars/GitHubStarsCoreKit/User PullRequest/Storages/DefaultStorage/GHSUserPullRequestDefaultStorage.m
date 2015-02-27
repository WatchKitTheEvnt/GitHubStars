//
//  GHSUserPullRequestDefaultStorage.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserPullRequestDefaultStorage.h"

static NSString *const GHSUserPullRequestStoragePullRequestKey = @"GHSUserPullRequestStoragePullRequestKey";


@implementation GHSUserPullRequestDefaultStorage

- (instancetype)initWithStorageCordinator:(id<GHSStorageCordinator>)storageCordinator
{
    self = [super init];
    if (self)
    {
        _storageCordinator = storageCordinator;
    }
    return self;
}

- (void)saveUserPullRequest:(GHSUserPullRequest *)pullRequest
{
    [self.storageCordinator saveSerializableModel:pullRequest forKey:GHSUserPullRequestStoragePullRequestKey withCompletionHandler:^(NSError *error) {
        if (error)
        {
            NSLog(@"Error saving pullrequest list");
        }
    }];
}

- (GHSUserPullRequest *)loadUserPullRequest
{
    __block GHSUserPullRequest *pullrequest;
    [self.storageCordinator loadSerializableModelForKey:GHSUserPullRequestStoragePullRequestKey withCompletionHandler:^(GHSSerializableModel *model, NSError *error) {
        pullrequest =(GHSUserPullRequest*)model;
    }];
    return pullrequest;
}

- (void)clearUserPullRequest
{
    [self.storageCordinator clearSerializableModelForKey:GHSUserPullRequestStoragePullRequestKey withCompletionHandler:^(NSError *error) {
        if (error)
        {
            NSLog(@"Error on clear pullRequests");
        }
    }];
}


@end
