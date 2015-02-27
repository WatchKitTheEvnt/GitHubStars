//
//  GHSFakeApplication.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 15/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GHSFakeApplication : NSObject

@property (nonatomic) UIApplication *application;

- (instancetype)initWithApplication:(UIApplication *)application;

- (void)registerForRemoteNotifications;

- (void)unregisterForRemoteNotifications;

- (BOOL)isRegisteredForRemoteNotifications;

@end
