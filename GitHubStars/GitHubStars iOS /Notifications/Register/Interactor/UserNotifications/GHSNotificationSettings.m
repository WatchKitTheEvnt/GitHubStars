//
//  GHSUserNotification.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 15/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSNotificationSettings.h"


static const UIUserNotificationType GHSNotificationTypes = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge;

@interface GHSNotificationSettings ()

@property (nonatomic) BOOL badgeSupported;
@property (nonatomic) BOOL alertSupported;

@end

@implementation GHSNotificationSettings

- (UIUserNotificationSettings *)userNotificationsSettingsForUserTypesDesired
{
    return [UIUserNotificationSettings settingsForTypes:GHSNotificationTypes categories:nil];
}

- (void)updateUserNotificationWithSettings:(UIUserNotificationSettings *)userNotificationSettings
{
    UIUserNotificationType types = userNotificationSettings.types;
    if (types & UIUserNotificationTypeBadge)
    {
        self.badgeSupported = YES;
    }
    if (types & UIUserNotificationTypeAlert)
    {
        self.alertSupported = YES;
    }
}

@end
