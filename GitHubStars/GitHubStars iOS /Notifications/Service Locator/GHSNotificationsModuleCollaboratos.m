//
//  GHSNotificationsModuleCollaboratos.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSNotificationsModuleCollaboratos.h"

#import "GHSNotificationsRegister.h"
#import "GHSRegisterUserNotifications.h"
#import "GHSFakePushNotifications.h"
#import "GHSRegisterPushNotifications.h"
#import "GHSFakeApplication.h"
#import "GHSNotificationSettings.h"


@implementation GHSNotificationsModuleCollaboratos

- (id)notificationsRegister
{
    return [[GHSNotificationsRegister alloc] initWithRemoteNotification:[self fakePushNotifications]
                                                       userNotification:[self userNotifications]];
}

#pragma mark - Internal Notifications Dependencies

- (id)fakePushNotifications
{
    return [[GHSFakePushNotifications alloc] initWithFakeApplication:[self fakeApplication]];
}

- (id)pushNotifications
{
    return [[GHSRegisterPushNotifications alloc] initWithApplication:[self application]];
}

- (id)userNotifications
{
    return [[GHSRegisterUserNotifications alloc] initWithApplication:[self application]
                                                notificationSettings:[self notificationSettings]];
}

- (id)notificationSettings
{
    return [[GHSNotificationSettings alloc] init];
}

- (id)application
{
    return [UIApplication sharedApplication];
}

- (id)fakeApplication
{
    return [[GHSFakeApplication alloc] initWithApplication:[self application]];
}


@end
