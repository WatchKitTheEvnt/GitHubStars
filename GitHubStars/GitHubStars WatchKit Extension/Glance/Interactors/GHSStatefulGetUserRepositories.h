//
//  GHSStatefulUserRepositories.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHSUserRepositories;
@class GHSUserRepositoriesStorage;

typedef void (^GHSUserRepositoriesFetchCompletionBlock)(GHSUserRepositories *userRepositories);

/**
 Get GHSUserRepositories model using a callback based API.
 */
@interface GHSStatefulGetUserRepositories : NSObject

@property (nonatomic, readonly) GHSUserRepositoriesStorage *userRepositoriesStorage;

- (instancetype)initWithUserRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage;

/**
 Load persisted repos. Returns GHSUserRepositories with the list of persisted repos, or nil if there is no persisted repos.
 */
- (GHSUserRepositories *)loadUserRepositories;

/** 
 Load persisted user repos asynchronously. The loading is done in background. On completion calls the provided block on main thread,
 passing the array of loaded repos, or nil if there was no persisted repos.
 */
- (void)loadUserRepositoriesWithCompletion:(GHSUserRepositoriesFetchCompletionBlock)completion;

/** 
 Fetch user repos from server. This method returns immediately. On completion calls the provided block passing the array of fetched
 repos.
 */
- (void)fetchUserRepositoriesWithCompletion:(GHSUserRepositoriesFetchCompletionBlock)completion;

@end
