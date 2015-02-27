//
//  GHSPopViewControllerNavigationRoute.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 25/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSPopViewControllerNavigationRoute.h"

/**
 This is an special route: the UINavigationController will manage the pop event, so we don't need to provide a ViewController or a
 ViewModel. Both of them are already retained by the UINavigationController, and the Navigation is still observing the status of
 the ViewModel. This status was set to DoneWithContext(whatever) when the ViewController received viewWillDissapear and it will be
 set back to DoingStuff in viewWillAppear. This means we can sit and wait for the UINAvigationController to do its job. Easy money.
 */
@implementation GHSPopViewControllerNavigationRoute

@synthesize navigationType = _navigationType;
@synthesize viewModel = _viewModel;
@synthesize viewController = _viewController;

+ (instancetype)routeWithContext:(id)context storyboard:(UIStoryboard *)storyboard navigationType:(GHSNavigationRouteNavigationType)navigationType
{
    return [[self alloc] initWithNavigationType:navigationType];
}

- (instancetype)initWithNavigationType:(GHSNavigationRouteNavigationType)navigationType
{
    self = [super init];
    if (self)
    {
        _navigationType = navigationType;
    }
    return self;
}

@end
