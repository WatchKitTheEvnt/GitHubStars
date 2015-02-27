//
//  GHSNotificationsPresenter.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <GitHubStarsCommonsKit/GitHubStarsCommonsKit.h>
#import "GHSNotificationsPresenter.h"

@implementation GHSNotificationsPresenter

- (void)presentNewStartNotificationForRepository:(NSString *)repositoryName
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = NSLocalizedString(@"New Star", @"New star notification alert body");
    localNotification.userInfo = @{GHSNewStarLocalNotificationKey : repositoryName};
    localNotification.category = GHSNewStarLocalNotificationCategoryKey;
}

@end
