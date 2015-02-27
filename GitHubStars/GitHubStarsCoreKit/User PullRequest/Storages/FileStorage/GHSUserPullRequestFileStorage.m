//
//  GHSUserPullRequestStorage.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserPullRequestFileStorage.h"

static NSString *const GHSUserPullRequestFileStorageKey = @"PullRequestList";
static NSString *const GHSUserPullRequestFileStorageFileExtensionKey = @"list";

@implementation GHSUserPullRequestFileStorage

- (instancetype)initWithStorageCordinator:(id<GHSStorageCordinator>)storageCordinator
{
    self = [super init];
    if (self)
    {
        _storageCordinator = storageCordinator;
    }
    return self;
}

- (void)saveUserPullRequest:(GHSUserPullRequest *)pullRequest withCompletionHandler:(void (^)(NSError *error))completionHandler
{
    [self.storageCordinator saveSerializableModel:pullRequest forKey:GHSUserPullRequestFileStorageKey withCompletionHandler:^(NSError *error) {
        completionHandler(error);
    }];
}

- (void)loadUserPullRequestWithCompletionHandler:(void (^)(GHSUserPullRequest *pullRequest, NSError *error))completionHandler
{
    [self.storageCordinator loadSerializableModelForKey:GHSUserPullRequestFileStorageKey withCompletionHandler:^(GHSSerializableModel *model, NSError *error) {
        completionHandler((GHSUserPullRequest *)model, error);
    }];
}

- (void)clearUserPullRequestWithCompletionHandler:(void (^)(NSError *))completionHandler
{
    [self.storageCordinator clearSerializableModelForKey:GHSUserPullRequestFileStorageKey withCompletionHandler:^(NSError *error) {
        completionHandler(error);
    }];
}

@end
