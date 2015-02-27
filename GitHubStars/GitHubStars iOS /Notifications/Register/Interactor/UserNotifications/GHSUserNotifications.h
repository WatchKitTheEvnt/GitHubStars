//
//  GHSUserNotificationsProtocol.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHSNotificationSettings;
@protocol GHSUserNotifications <NSObject>

- (void)registerUserNotifications;

- (GHSNotificationSettings *)currentUpdateNotificationsSettings;

@end
