//
//  GHSUserNotifications.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GHSUserNotifications.h"
#import "GHSNotificationSettings.h"

@interface GHSRegisterUserNotifications : NSObject <GHSUserNotifications>

@property (nonatomic, readonly) UIApplication *application;
@property (nonatomic, readonly) GHSNotificationSettings *notificationSettings;

- (instancetype)initWithApplication:(UIApplication *)application
               notificationSettings:(GHSNotificationSettings *)notificationSettings;

@end
