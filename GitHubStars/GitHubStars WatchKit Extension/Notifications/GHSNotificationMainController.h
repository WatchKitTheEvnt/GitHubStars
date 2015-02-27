//
//  GHSNotificationService.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
#import "GHSStatefulGetUserRepositories.h"
#import "GHSFetchPullRequestList.h"


@protocol GHSNotificationsMainControllerDelegate;
@interface GHSNotificationMainController : NSObject

@property (nonatomic, readonly) GHSStatefulGetUserRepositories *getUserRepositories;
@property (nonatomic, readonly) GHSFetchPullRequestList *fetchPullRequest;
@property (nonatomic, weak) id <GHSNotificationsMainControllerDelegate> delegate;

- (instancetype)initWithUserRepositoriesInteractor:(GHSStatefulGetUserRepositories *)getUserRepositories fectPullRequestInteractor:(GHSFetchPullRequestList *)fetchPullRequest;

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification;

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification;

@end

@class GHSRepository;
@class GHSPullRequest;
@protocol GHSNotificationsMainControllerDelegate <NSObject>

- (void)notificationsMainController:(GHSNotificationMainController *)mainController didUpdateUserRepository:(GHSRepository *)repository;

- (void)notificationsMainController:(GHSNotificationMainController *)mainController didUpdatePullRequest:(GHSPullRequest *)pullRequest;

@end
