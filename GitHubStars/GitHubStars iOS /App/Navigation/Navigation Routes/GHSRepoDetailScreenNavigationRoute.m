//
//  GHSRepoDetailScreenNavigationRoute.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 24/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSRepoDetailScreenNavigationRoute.h"

#import <OctoKit/OCTClient.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSNavigationMacros.h"
#import "GHSRepoSelectedContext.h"
#import "GHSRepositoryDetailNetwork.h"
#import "GHSRepoDetailViewModel.h"
#import "GHSRepoDetailViewController.h"

static NSString *const kRepoDetailScreenID = @"GHSRepoDetailViewControllerID";

@implementation GHSRepoDetailScreenNavigationRoute

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
        GHSRepoDetailViewModel *repoDetailViewModel = [self repoDetailViewModelWithContext:context];
        GHSRepoDetailViewController *repoDetailViewController = [self repoDetailViewControllerWithStoryboard:storyboard repoDetailViewModel:repoDetailViewModel];
        
        _navigationType = navigationType;
        _viewModel =  repoDetailViewModel;
        _viewController = repoDetailViewController;
    }
    return self;
}

- (GHSRepoDetailViewModel *)repoDetailViewModelWithContext:(id)context
{
    enforceContextIsInstanceOf(context, [GHSRepoSelectedContext class]);
    GHSRepoSelectedContext *repoSelectedContext = (GHSRepoSelectedContext *)context;
    GHSRepository *selectedRepo = repoSelectedContext.selectedRepo;
    OCTClient *authenticatedClient = repoSelectedContext.authenticatedClient;
    GHSRepositoryDetailNetwork *repositoryDetailNetwork = [[GHSRepositoryDetailNetwork alloc] initWithAuthenticatedClient:authenticatedClient];
    GHSRepoDetailViewModel *repoDetailViewModel = [[GHSRepoDetailViewModel alloc] initWithSelectedRepo:selectedRepo repositoryDetailNetwork:repositoryDetailNetwork];
    return repoDetailViewModel;
}

- (GHSRepoDetailViewController *)repoDetailViewControllerWithStoryboard:(UIStoryboard *)storyboard
                                                    repoDetailViewModel:(GHSRepoDetailViewModel *)repoDetailViewModel
{
    GHSRepoDetailViewController *repoDetailViewController = [storyboard instantiateViewControllerWithIdentifier:kRepoDetailScreenID];
    repoDetailViewController.viewModel = repoDetailViewModel;
    return repoDetailViewController;
}

@end
