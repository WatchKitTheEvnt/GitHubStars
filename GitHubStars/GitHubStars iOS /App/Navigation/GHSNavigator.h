//
//  GHSNavigator.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 07/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class GHSRootViewController;
@class GHSNavigationRoutePlanner;

/**
 Orchestrates the navigation of the app. This component is responsible to perform all the transitions from one
 screen to another. To do so, it observes the status property of ViewModels.
 */
@interface GHSNavigator : NSObject

@property (nonatomic, readonly) GHSRootViewController *rootViewController;
@property (nonatomic, readonly) GHSNavigationRoutePlanner *routePlanner;

- (instancetype)initWithRootViewController:(GHSRootViewController *)rootViewController
                              routePlanner:(GHSNavigationRoutePlanner *)routePlanner;

- (void)bindRootViewController;

@end
