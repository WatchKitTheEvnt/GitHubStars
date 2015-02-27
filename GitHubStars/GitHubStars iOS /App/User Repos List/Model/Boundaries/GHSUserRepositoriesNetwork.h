//
//  GHSUserRepositoriesNetwork.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

@class RACSignal;
@class OCTClient;

@interface GHSUserRepositoriesNetwork : NSObject

@property (nonatomic, readonly) OCTClient *authenticatedClient;

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient;

- (RACSignal *)fetchUserRepositories;

@end
