//
//  GHSUserNotification.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 15/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIUserNotificationSettings.h>

@interface GHSNotificationSettings : NSObject

@property (nonatomic, getter=isBadgeSupported, readonly) BOOL badgeSupported;
@property (nonatomic, getter=isAlertSupported, readonly) BOOL alertSupported;

- (UIUserNotificationSettings *)userNotificationsSettingsForUserTypesDesired;

- (void)updateUserNotificationWithSettings:(UIUserNotificationSettings *)userNotificationSettings;

@end
