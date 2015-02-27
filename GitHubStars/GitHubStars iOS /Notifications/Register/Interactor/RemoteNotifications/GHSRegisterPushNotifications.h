//
//  GHSRemoteNotifications.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GHSRemoteNotifications.h"

@interface GHSRegisterPushNotifications : NSObject <GHSRemoteNotifications>

@property (nonatomic, readonly) UIApplication *application;

- (instancetype)initWithApplication:(UIApplication *)application;

@end
