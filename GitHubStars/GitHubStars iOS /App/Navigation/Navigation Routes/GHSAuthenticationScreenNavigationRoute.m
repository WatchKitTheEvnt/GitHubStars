//
//  GHSAuthenticationScreenNavigationRoute.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 13/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSAuthenticationScreenNavigationRoute.h"

#import "GHSNavigationMacros.h"
#import "GHSAuthenticationEntity.h"
#import "GHSAuthenticationViewModel.h"
#import "GHSAuthenticationViewController.h"

static NSString *const kAuthenticationScreenID = @"GHSAuthenticationViewControllerStoryboardID";

@implementation GHSAuthenticationScreenNavigationRoute

@synthesize navigationType = _navigationType;
@synthesize viewModel = _viewModel;
@synthesize viewController = _viewController;

+ (instancetype)routeWithContext:(id)context storyboard:(UIStoryboard *)storyboard navigationType:(GHSNavigationRouteNavigationType)navigationType
{
    return [[self alloc] initWithContext:context storyboard:storyboard navigationType:navigationType];
}

- (instancetype)initWithContext:(id)context storyboard:(UIStoryboard *)storyboard navigationType:(GHSNavigationRouteNavigationType)navigationType
{
    self = [super init];
    if (self)
    {
        GHSAuthenticationViewModel *authenticationViewModel = [self authenticationViewModelWithContext:context];
        GHSAuthenticationViewController *authenticationViewController = [self authenticationViewControllerWithStoryborad:storyboard
                                                                                                 authenticationViewModel:authenticationViewModel];
        
        _navigationType = navigationType;
        _viewModel = authenticationViewModel;
        _viewController = authenticationViewController;
    }
    return self;
}

- (GHSAuthenticationViewModel *)authenticationViewModelWithContext:(id)context
{
    enforceContextIsInstanceOf(context, [GHSAuthenticationEntity class]);
    GHSAuthenticationEntity *authenticationEntity = (GHSAuthenticationEntity *)context;
    GHSAuthenticationViewModel *authenticationViewModel = [[GHSAuthenticationViewModel alloc] initWithAuthenticationEntity:authenticationEntity];
    return authenticationViewModel;
}

- (GHSAuthenticationViewController *)authenticationViewControllerWithStoryborad:(UIStoryboard *)storyboard
                                                        authenticationViewModel:(GHSAuthenticationViewModel *)authenticationViewModel
{
    GHSAuthenticationViewController *authenticationViewController = [storyboard instantiateViewControllerWithIdentifier:kAuthenticationScreenID];
    authenticationViewController.viewModel = authenticationViewModel;
    return authenticationViewController;
}

@end
