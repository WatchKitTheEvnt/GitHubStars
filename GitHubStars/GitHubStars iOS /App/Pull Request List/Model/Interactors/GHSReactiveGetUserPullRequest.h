//
//  GHSReactiveGetUserPullRequest.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 25/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

@class RACSignal;
@class GHSRepository;
@class GHSFetchUserPullRequest;

@interface GHSReactiveGetUserPullRequest : NSObject

@property (nonatomic, readonly) GHSFetchUserPullRequest *fetchUserPullRequest;
@property (nonatomic, readonly) id <GHSPullRequestAsyncStorage> userPullRequestFileStorage;

- (instancetype)initWithFetchUserPullRequest:(GHSFetchUserPullRequest *)fetchUserPullRequest
                  userPullRequestFileStorage:(id<GHSPullRequestAsyncStorage>)userPullRequestFileStorage;

- (RACSignal *)getUserPullRequestSkippingCacheWithRefreshSignal:(RACSignal *)refreshSignal
                                              forRepositoryName:(NSString *)repositoryName
                                                          owner:(NSString *)owner;

@end
