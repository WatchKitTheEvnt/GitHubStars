//
//  GHSReactiveUserRepositories.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class GHSFetchUserRepositories;
@class GHSLoadUserRepositories;
@class GHSUserRepositoriesStorage;

/**
 Get GHSUserRepositories model using a reactive API.
 */
@interface GHSReactiveGetUserRepositories : NSObject

@property (nonatomic, readonly) GHSFetchUserRepositories *fetchUserRepositories;
@property (nonatomic, readonly) GHSLoadUserRepositories *loadUserRepositories;
@property (nonatomic, readonly) GHSUserRepositoriesStorage *userRepositoriesStorage;

- (instancetype)initWithFetchUserRepositories:(GHSFetchUserRepositories *)fetchUserRepositories
                         loadUserRepositories:(GHSLoadUserRepositories *)loadUserRepositories
                      userRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage;

/**
 Returns a signal that will send next with the cached repos list (if exists), then a next with an updated repos list fetched
 from network. Finally, each time refreshSignal sends next, this signal will fetch fresh data from the server and send it on
 next. All the repos lists fetched from network are automatically persisted for future use.

 The refreshSignal can be nil, in which case signal will send next with data loaded from cache, then next with data fetched
 from network, then complete.
 
 If the fresh data from network is ready before the cached version is loaded, then the cached version is ignored (i.e. never
 sent), and the first next event that this signal sends contains the fetched data.

 This signal sends GHSUserRepositories objects.
 */
- (RACSignal *)getUserRepositoriesWithRefreshSignal:(RACSignal *)refreshSignal;

/**
 Returns a signal that will send next with an updated repos list fetched from network. Each time refreshSignal sends next, 
 this signal will fetch fresh data from the server and send it on next. All the repos lists fetched from network are
 automatically persisted for future use.
 
 The refreshSignal can be nil, in which case signal will send next with data fetched from network, then complete.
 
 This signal sends GHSUserRepositories objects.
 */
- (RACSignal *)getUserRepositoriesSkippingCacheWithRefreshSignal:(RACSignal *)refreshSignal;

@end
