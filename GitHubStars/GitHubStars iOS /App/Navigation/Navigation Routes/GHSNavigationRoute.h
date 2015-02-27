//
//  GHSNavigationRoute.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 13/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GHSViewModel;

typedef NS_ENUM(NSUInteger, GHSNavigationRouteNavigationType) {
    GHSNavigationRouteNavigationTypeFirstScreen,
    GHSNavigationRouteNavigationTypeTransition,
    GHSNavigationRouteNavigationTypePush,
    GHSNavigationRouteNavigationTypePop,
};

/**
 A navigation route is an abstract concept that describes the navigation from the current screen to a destination screen.
 The navigation route specifies:
    - The destination screen, by providing a ViewModel and a ViewController.
    - The type of the navigation, which could be a UINavigationController push or pop, a ViewController transition, etc.
 */
@protocol GHSNavigationRoute <NSObject>

/** The type of navigation the this route requieres (transition, push, pop, etc.) */
@property (nonatomic, readonly) GHSNavigationRouteNavigationType navigationType;

/** The ViewModel of the destination screen */
@property (nonatomic, readonly) GHSViewModel *viewModel;

/** The ViewController of the destination screen */
@property (nonatomic, readonly) UIViewController *viewController;

/** Conveninence method to build a navigation route providing its fundamental building blocks */
+ (instancetype)routeWithContext:(id)context storyboard:(UIStoryboard *)storyboard navigationType:(GHSNavigationRouteNavigationType)navigationType;

@end
