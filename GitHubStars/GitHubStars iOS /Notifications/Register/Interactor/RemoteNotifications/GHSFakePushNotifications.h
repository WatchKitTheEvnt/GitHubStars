//
//  GHSFakePushNotifications.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 14/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSRemoteNotifications.h"

@class GHSFakeApplication;
@interface GHSFakePushNotifications : NSObject <GHSRemoteNotifications>

@property (nonatomic) GHSFakeApplication *application;

- (instancetype)initWithFakeApplication:(GHSFakeApplication *)application;

@end
