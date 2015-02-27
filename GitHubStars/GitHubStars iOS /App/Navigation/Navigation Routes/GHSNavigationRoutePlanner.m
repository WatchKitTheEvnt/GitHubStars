//
//  GHSNavigationRoutePlanner.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 13/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSNavigationRoutePlanner.h"

#import <OctoKit/OCTClient.h>
#import "GHSAuthenticationScreenNavigationRoute.h"
#import "GHSRootViewModel.h"
#import "GHSAuthenticationViewModel.h"
#import "GHSAuthenticationEntity.h"
#import "GHSUserReposListScreenNavigationRoute.h"
#import "GHSUserReposListViewModel.h"
#import "GHSRepoSelectedContext.h"
#import "GHSRepoDetailScreenNavigationRoute.h"
#import "GHSRepoDetailViewModel.h"
#import "GHSPopViewControllerNavigationRoute.h"

@implementation GHSNavigationRoutePlanner

- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard
{
    self = [super init];
    if (self)
    {
        _storyboard = storyboard;
    }
    return self;
}

- (id<GHSNavigationRoute>)routeFromViewModel:(GHSViewModel *)viewModel context:(id)context
{
    id<GHSNavigationRoute> route = nil;
    
    // Navigation routes from RootViewController
    if ([viewModel isKindOfClass:[GHSRootViewModel class]])
    {
        if ([context isKindOfClass:[GHSAuthenticationEntity class]])
        {
            route = [GHSAuthenticationScreenNavigationRoute routeWithContext:context storyboard:self.storyboard navigationType:GHSNavigationRouteNavigationTypeFirstScreen];
        }
        else if ([context isKindOfClass:[OCTClient class]])
        {
            route = [GHSUserReposListScreenNavigationRoute routeWithContext:context storyboard:self.storyboard navigationType:GHSNavigationRouteNavigationTypeFirstScreen];
        }
    }
    // Navigation routes from Authentication
    else if ([viewModel isKindOfClass:[GHSAuthenticationViewModel class]])
    {
        route = [GHSUserReposListScreenNavigationRoute routeWithContext:context storyboard:self.storyboard navigationType:GHSNavigationRouteNavigationTypeTransition];
    }
    // Navigation routes from User Repos
    else if ([viewModel isKindOfClass:[GHSUserReposListViewModel class]])
    {
        if ([context isKindOfClass:[GHSAuthenticationEntity class]])
        {
            route = [GHSAuthenticationScreenNavigationRoute routeWithContext:context storyboard:self.storyboard navigationType:GHSNavigationRouteNavigationTypeTransition];
        }
        else if ([context isKindOfClass:[GHSRepoSelectedContext class]])
        {
            route = [GHSRepoDetailScreenNavigationRoute routeWithContext:context storyboard:self.storyboard navigationType:GHSNavigationRouteNavigationTypePush];
        }
    }
    // Navigation routes from Repo Detail
    else if ([viewModel isKindOfClass:[GHSRepoDetailViewModel class]])
    {
        route = [GHSPopViewControllerNavigationRoute routeWithContext:context storyboard:self.storyboard navigationType:GHSNavigationRouteNavigationTypePop];
    }

    return route;
}

@end
