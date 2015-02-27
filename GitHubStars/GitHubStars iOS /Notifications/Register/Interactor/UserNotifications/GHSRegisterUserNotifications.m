//
//  GHSUserNotifications.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSRegisterUserNotifications.h"

@implementation GHSRegisterUserNotifications

- (instancetype)initWithApplication:(UIApplication *)application notificationSettings:(GHSNotificationSettings *)notificationSettings
{
    self = [super init];
    if (self)
    {
        _application = application;
        _notificationSettings = notificationSettings;
    }
    return self;
}

- (void)registerUserNotifications
{
    [self.application registerUserNotificationSettings:[self.notificationSettings userNotificationsSettingsForUserTypesDesired]];
}

- (GHSNotificationSettings *)currentUpdateNotificationsSettings
{
    UIUserNotificationSettings *currentSettings = [self.application currentUserNotificationSettings];
    [self.notificationSettings updateUserNotificationWithSettings:currentSettings];
    return self.notificationSettings;
}

@end
