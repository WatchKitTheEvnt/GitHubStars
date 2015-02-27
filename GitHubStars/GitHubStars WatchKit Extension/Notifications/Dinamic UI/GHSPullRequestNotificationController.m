//
//  GHSPullRequestNotificationController.m
//  GitHubStars
//
//  Created by Eduardo González Fernández on 10/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSPullRequestNotificationController.h"
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

// Standard remote notification payload keys.
static NSString *const apsKey = @"aps";
static NSString *const alertKey = @"alert";
static NSString *const titleKey = @"title";

// Custom Pullrequest Notification Data key
static NSString *const pullRequestRepositoryNameKey = @"pullRequestRepositoryName";
static NSString *const pullRequestStateKey = @"pullRequestState";

@interface GHSPullRequestNotificationController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *repositoryNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *stateLabel;

@end

@implementation GHSPullRequestNotificationController

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - Notifications Handlers

- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    
    [self setUpInterfazWithTitle:localNotification.alertTitle notificationInfo:localNotification.userInfo];
    
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeDefault);
}

- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    
    NSDictionary *aps = remoteNotification[apsKey][alertKey];
    NSString *title = aps[titleKey];
    
    [self setUpInterfazWithTitle:title notificationInfo:remoteNotification];
    
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}

#pragma mark - Configure Interfaz

- (void)setUpInterfazWithTitle:(NSString *)title notificationInfo:(NSDictionary *)notificationInfo
{
    NSString *repositoryName = notificationInfo[pullRequestRepositoryNameKey];
    NSString *state = notificationInfo[pullRequestStateKey];
    
    [self.titleLabel setText:title];
    [self.repositoryNameLabel setText:repositoryName];
    [self.stateLabel setText:state];
}


@end



