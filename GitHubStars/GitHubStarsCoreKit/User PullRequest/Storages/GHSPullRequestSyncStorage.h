//
//  GHSPullRequestSyncStorage.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSUserPullRequest.h"

@protocol GHSPullRequestSyncStorage <NSObject>

- (void)saveUserPullRequest:(GHSUserPullRequest *)pullRequest;

- (GHSUserPullRequest *)loadUserPullRequest;

- (void)clearUserPullRequest;

@end
