//
//  GHSPullRequestStorage.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSUserPullRequest.h"

@protocol GHSPullRequestAsyncStorage<NSObject>

- (void)saveUserPullRequest:(GHSUserPullRequest *)pullRequest withCompletionHandler:(void (^)(NSError *error))completionHandler;

- (void)loadUserPullRequestWithCompletionHandler:(void (^)(GHSUserPullRequest *pullRequest, NSError *error))completionHandler;

- (void)clearUserPullRequestWithCompletionHandler:(void (^)(NSError *error))completionHandler;

@end

