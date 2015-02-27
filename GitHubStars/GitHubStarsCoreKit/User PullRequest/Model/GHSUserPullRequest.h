//
//  GHSUserPullRequest.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSSerializableModel.h"

@class GHSPullRequest;
@interface GHSUserPullRequest : GHSSerializableModel

/** Array of GHSPullRequest objects */
@property (nonatomic, copy, readonly) NSArray *pullRequest;

@property (nonatomic, readonly) GHSPullRequest *latestPullRequest;

- (instancetype)initWithPullRequest:(NSArray *)pullRequest;

- (GHSPullRequest *)pullRequestByTitle:(NSString *)title;

@end
