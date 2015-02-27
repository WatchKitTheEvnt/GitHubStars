//
//  GHSUserPullRequestNetwork.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 24/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class OCTClient;
@class GHSRepository;

@interface GHSUserPullRequestNetwork : NSObject

@property (nonatomic, readonly) OCTClient *authenticatedClient;

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient;

- (RACSignal *)fetchUserPullRequestForRepositoryName:(NSString *)repositoryName owner:(NSString *)owner;

@end
