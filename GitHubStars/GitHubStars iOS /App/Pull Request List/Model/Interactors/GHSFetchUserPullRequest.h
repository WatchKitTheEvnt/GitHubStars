//
//  GHSFecthUserPullRequest.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 24/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class GHSRepository;
@class GHSUserPullRequestNetwork;

@interface GHSFetchUserPullRequest : NSObject

@property (nonatomic, readonly) GHSUserPullRequestNetwork *userPullRequestNetwork;

- (instancetype)initWithUserPullRequestNetwork:(GHSUserPullRequestNetwork *)userPullRequestNetwork;

- (RACSignal *)fetchUserPullRequestWithRefreshSignal:(RACSignal *)refreshSignal
                                   forRepositoryName:(NSString *)repositoryName
                                               owner:(NSString *)owner;
@end
