//
//  GHSNotificationsRegister.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSRemoteNotifications.h"
#import "GHSUserNotifications.h"

@interface GHSNotificationsRegister : NSObject

@property (nonatomic, readonly) id <GHSRemoteNotifications> remoteNotification;
@property (nonatomic, readonly) id <GHSUserNotifications> userNotification;


- (instancetype)initWithRemoteNotification:(id<GHSRemoteNotifications>)remoteNotification
                          userNotification:(id<GHSUserNotifications>)userNotification;

- (void)registerForNotifications;

- (void)registerForRemoteNotifications;

@end
