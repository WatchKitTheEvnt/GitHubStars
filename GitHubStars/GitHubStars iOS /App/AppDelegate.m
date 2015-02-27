//
//  AppDelegate.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 02/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "AppDelegate.h"

#import "GHSNavigator.h"
#import "GHSNavigationRoutePlanner.h"
#import "GHSRootViewController.h"
#import "GHSRootViewModel.h"

#import "GHSNotificationsModuleCollaboratos.h"
#import "GHSNotificationsRegister.h"

#import "GHSWatchKitExtensionServiceModule.h"
#import "GHSWatchKitExtensionService.h"

static NSString *const kRootViewControllerStoryboardID = @"RootViewController";

@interface AppDelegate ()

@property (nonatomic) GHSNavigator *navigator;
@property (nonatomic) GHSNotificationsRegister *notificationsRegister;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Extract root view controller from storyboard and provide a ViewModel for it
    GHSRootViewController *rootViewController = (GHSRootViewController *)self.window.rootViewController;
    rootViewController.viewModel = [[GHSRootViewModel alloc] init];
    
    // Set up and retain the navigator object
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GHSNavigationRoutePlanner *routePlanner = [[GHSNavigationRoutePlanner alloc] initWithStoryboard:mainStoryboard];
    self.navigator = [[GHSNavigator alloc] initWithRootViewController:rootViewController routePlanner:routePlanner];
    [self.navigator bindRootViewController];
    
    GHSNotificationsModuleCollaboratos *notificationsModuleCollaborators = [[GHSNotificationsModuleCollaboratos alloc] init];
    self.notificationsRegister = [notificationsModuleCollaborators notificationsRegister];
    [self.notificationsRegister registerForNotifications];

    return YES;
}



#pragma mark - WatchKit Extension Request Method

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    NSLog(@"WatchKit Request Received: %@", userInfo);
    GHSWatchKitExtensionServiceModule *watchKitExtensionServiceModule = [[GHSWatchKitExtensionServiceModule alloc] init];
    GHSWatchKitExtensionService *watchKitExtensionService = [[GHSWatchKitExtensionService alloc] initWithWatchKitExtensionServiceModule:watchKitExtensionServiceModule];
    [watchKitExtensionService application:application handleWatchKitExtensionRequest:userInfo reply:reply];
}

#pragma mark - Local/Push Notifications AppDelegate Methods

 - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [self.notificationsRegister registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Register with device token %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"fail to register for remote notifications");
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
    
    NSLog(@"Handle Actio ");
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    NSLog(@"");
}

@end
