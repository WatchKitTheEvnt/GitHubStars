//
//  GHSNotificationsRegister.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSNotificationsRegister.h"

@implementation GHSNotificationsRegister


- (instancetype)initWithRemoteNotification:(id<GHSRemoteNotifications>)remoteNotification
                          userNotification:(id<GHSUserNotifications>)userNotification
{
    self = [super init];
    if (self = [super init])
    {
        _remoteNotification = remoteNotification;
        _userNotification = userNotification;
    }
    return self;
}

- (void)registerForNotifications
{
    [self.userNotification registerUserNotifications];
}

- (void)registerForRemoteNotifications
{
    if (![self.remoteNotification isRegisteredForNotifications])
    {
        [self.remoteNotification registerForNotifications];
    }
}

- (void)unregisterRemoteNotifications
{
    if ([self.remoteNotification isRegisteredForNotifications])
    {
        [self.remoteNotification unregisterForNotifications];
    }
}

@end
