//
//  GHSUserReposListScreenNavigationRoute.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 18/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSUserReposListScreenNavigationRoute.h"

#import <OctoKit/OCTClient.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSNavigationMacros.h"
#import "GHSUserReposListViewModel.h"
#import "GHSUserReposListViewController.h"
#import "GHSAuthenticationEntity.h"
#import "GHSReactiveGetUserRepositories.h"
#import "GHSUserRepositoriesNetwork.h"
#import "GHSFetchUserRepositories.h"
#import "GHSLoadUserRepositories.h"

static NSString *const kUserReposListNavigationControllerID = @"GHSUserReposListNavigationControllerID";

@implementation GHSUserReposListScreenNavigationRoute

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
        GHSUserReposListViewModel *userReposListViewModel = [self userReposListViewModelWithContext:context];
        UINavigationController *userReposListNavigationController = [self userReposListViewControllerWithStoryboard:storyboard
                                                                                             userReposListViewModel:userReposListViewModel];
        
        _navigationType = navigationType;
        _viewModel =  userReposListViewModel;
        _viewController = userReposListNavigationController;
    }
    return self;
}

- (GHSUserReposListViewModel *)userReposListViewModelWithContext:(id)context
{
    enforceContextIsInstanceOf(context, [OCTClient class]);
    OCTClient *authenticatedClient = (OCTClient *)context;
    GHSAuthenticationEntity *authenticationEntity = [[GHSAuthenticationEntity alloc] init];
    GHSUserRepositoriesNetwork *userRepositoriesNetwork = [[GHSUserRepositoriesNetwork alloc] initWithAuthenticatedClient:authenticatedClient];
    GHSUserRepositoriesStorage *userRepositoriesStorage = [[GHSUserRepositoriesStorage alloc] init];
    GHSFetchUserRepositories *fetchUserRepositories = [[GHSFetchUserRepositories alloc] initWithUserRepositoriesNetwork:userRepositoriesNetwork];
    GHSLoadUserRepositories *loadUserRepositories = [[GHSLoadUserRepositories alloc] initWithUserRepositoriesStorage:userRepositoriesStorage];
    GHSReactiveGetUserRepositories *getUserRepositories = [[GHSReactiveGetUserRepositories alloc] initWithFetchUserRepositories:fetchUserRepositories loadUserRepositories:loadUserRepositories userRepositoriesStorage:userRepositoriesStorage];
    GHSUserInfoViewModel *userInfoViewModel = [[GHSUserInfoViewModel alloc] initWithAuthenticatedClient:authenticatedClient authenticationEntity:authenticationEntity userRepositoriesStorage:userRepositoriesStorage];
    GHSUserReposListViewModel *userReposListViewModel = [[GHSUserReposListViewModel alloc] initWithGetUserRepositories:getUserRepositories userInfoViewModel:userInfoViewModel authenticatedClient:authenticatedClient];
    return userReposListViewModel;
}

- (UINavigationController *)userReposListViewControllerWithStoryboard:(UIStoryboard *)storyboard
                                               userReposListViewModel:(GHSUserReposListViewModel *)userReposListViewModel
{
    // Repos List is embedded in a NavigationController
    UINavigationController *navigationControllerContainingUserReposListAsRoot = [storyboard instantiateViewControllerWithIdentifier:kUserReposListNavigationControllerID];
    UIViewController *topViewControllerInNavigation = navigationControllerContainingUserReposListAsRoot.topViewController;
    // Inject the ViewModel
    enforceControllerIsInstanceOf(topViewControllerInNavigation, [GHSUserReposListViewController class]);
    GHSUserReposListViewController *userReposListViewController = (GHSUserReposListViewController *)topViewControllerInNavigation;
    userReposListViewController.viewModel = userReposListViewModel;
    // Navigate to the NavigationController
    return navigationControllerContainingUserReposListAsRoot;
}

@end
