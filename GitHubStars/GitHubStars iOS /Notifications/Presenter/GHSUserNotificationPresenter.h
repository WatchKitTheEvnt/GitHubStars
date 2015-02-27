//
//  GHSUserNotificationPresenter.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GHSUserNotifications.h"


@interface GHSUserNotificationPresenter : NSObject

@property (nonatomic, readonly) UIApplication *application;
@property (nonatomic, readonly) id <GHSUserNotifications> userNotification;

- (instancetype)initWithApplication:(UIApplication *)application
                   userNotification:(id<GHSUserNotifications>)userNotification;

- (void)updateApplicationBadgeNumber:(NSInteger)badgetNumber;

- (void)presentLocalNotificationNow:(UILocalNotification *)notification;

- (void)scheduleLocalNotification:(UILocalNotification *)notification;

- (void)cancelLocalNotification:(UILocalNotification *)notification;

@end
