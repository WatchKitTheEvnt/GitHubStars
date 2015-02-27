//
//  GHSUserNotificationPresenter.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserNotificationPresenter.h"
#import "GHSNotificationSettings.h"

@implementation GHSUserNotificationPresenter

- (instancetype)initWithApplication:(UIApplication *)application
                   userNotification:(id<GHSUserNotifications>)userNotification
{
    self = [super init];
    if (self)
    {
        _application = application;
        _userNotification = userNotification;
    }
    return self;
}

- (void)presentLocalNotificationNow:(UILocalNotification *)notification
{
    GHSNotificationSettings *userNotificationSettings = [self.userNotification currentUpdateNotificationsSettings];
    if (userNotificationSettings.alertSupported)
    {
      [self.application presentLocalNotificationNow:notification];
    }
}

- (void)scheduleLocalNotification:(UILocalNotification *)notification
{
    GHSNotificationSettings *userNotificationSettings = [self.userNotification currentUpdateNotificationsSettings];
    if (userNotificationSettings.alertSupported)
    {
        [self.application scheduleLocalNotification:notification];
    }
}

- (void)cancelLocalNotification:(UILocalNotification *)notification
{
    [self.application cancelLocalNotification:notification];
}

- (void)updateApplicationBadgeNumber:(NSInteger)badgetNumber
{
    GHSNotificationSettings *userNotificationSettings = [self.userNotification currentUpdateNotificationsSettings];
    if (userNotificationSettings.badgeSupported)
    {
      [self.application setApplicationIconBadgeNumber:badgetNumber];
    }
}

@end
