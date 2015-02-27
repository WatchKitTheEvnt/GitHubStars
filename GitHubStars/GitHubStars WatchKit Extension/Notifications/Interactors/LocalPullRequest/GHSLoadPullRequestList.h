//
//  GHSGetUserPullRequestList.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSPullRequestSyncStorage.h"
#import "GHSPullRequestAsyncStorage.h"

@class GHSUserPullRequest;
@interface GHSLoadPullRequestList : NSObject

@property (nonatomic, readonly) id<GHSPullRequestSyncStorage>syncStorage;
@property (nonatomic, readonly) id<GHSPullRequestAsyncStorage>asyncStorage;


- (instancetype)initWithPullRequestSyncStorage:(id<GHSPullRequestSyncStorage>)syncStorage
                                  asyncStorage:(id<GHSPullRequestAsyncStorage>)asyncStorage;

- (GHSUserPullRequest *)loadUserPullRequest;

- (void)loadUserPullRequestWithCompletion:(void (^)(GHSUserPullRequest *pullRequest))completionHandler;

@end
