//
//  GHSFakeApplication.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 15/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSFakeApplication.h"

@interface GHSFakeApplication ()

@property (nonatomic) BOOL remoteNotificationsRegistered;
@property (nonatomic) NSData *deviceToken;

@end

@implementation GHSFakeApplication

- (instancetype)initWithApplication:(UIApplication *)application
{
    self = [super init];
    if (self)
    {
        _remoteNotificationsRegistered = NO;
        _deviceToken = nil;
        _application = application;
    }
    return self;
}

- (void)registerForRemoteNotifications
{
    self.remoteNotificationsRegistered = YES;
    self.deviceToken = [self randomDataWithBytes:100];
    [self.application.delegate application:self.application didRegisterForRemoteNotificationsWithDeviceToken:self.deviceToken];
}

- (void)unregisterForRemoteNotifications
{
    self.remoteNotificationsRegistered = NO;
}

- (BOOL)isRegisteredForRemoteNotifications
{
    return self.remoteNotificationsRegistered;
}

#pragma mark - Private Method

- (NSData *)randomDataWithBytes:(NSUInteger)length
{
    return [[NSFileHandle fileHandleForReadingAtPath: @"/dev/random"] readDataOfLength: length];
}
@end
