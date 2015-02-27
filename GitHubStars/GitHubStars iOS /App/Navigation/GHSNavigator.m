//
//  GHSNavigator.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 07/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSNavigator.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "GHSNavigationRoutePlanner.h"
#import "GHSNavigationRoute.h"
#import "GHSViewModel.h"
#import "GHSRootViewController.h"
#import "GHSRootViewModel.h"
#import "GHSNavigationMacros.h"

@interface GHSNavigator ()

@property (nonatomic) UIViewController *currentViewController;

@end

@implementation GHSNavigator

- (instancetype)initWithRootViewController:(GHSRootViewController *)rootViewController
                              routePlanner:(GHSNavigationRoutePlanner *)routePlanner
{
    self = [super init];
    if (self)
    {
        _rootViewController = rootViewController;
        _routePlanner = routePlanner;
        _currentViewController = nil;
    }
    return self;
}

#pragma mark - Navigation Bindings

- (void)bindRootViewController
{
    [self bindStatusOfViewModel:self.rootViewController.viewModel];
}

- (void)bindStatusOfViewModel:(GHSViewModel *)viewModel
{
    // Interested in Status only if it has changed AND it is DoneWithContext(whatever)
    @weakify(self);
    [[[RACObserve(viewModel, status)
        distinctUntilChanged]
        filter:^BOOL(GHSViewModelStatus *status) {
            return (status.currentStatus == GHSViewModelDone);
        }]
        subscribeNext:^(GHSViewModelStatus *status) {
            @strongify(self);
            [self navigateToNextScreenFromViewModel:viewModel context:status.context];
        }];
}

#pragma mark - Navigation

- (void)navigateToNextScreenFromViewModel:(GHSViewModel *)viewModel context:(id)context
{
    id<GHSNavigationRoute> route = [self.routePlanner routeFromViewModel:viewModel context:context];
    [self navigateFollowingRoute:route];
}

- (void)navigateFollowingRoute:(id<GHSNavigationRoute>)route
{
    if (route)
    {
        [self bindStatusOfViewModel:route.viewModel];
        [self navigateToViewController:route.viewController navigationType:route.navigationType];
    }
}

#pragma mark - Navigation Styles

- (void)navigateToViewController:(UIViewController *)viewController navigationType:(GHSNavigationRouteNavigationType)navigationType
{
    switch (navigationType)
    {
        case GHSNavigationRouteNavigationTypeFirstScreen:
        {
            [self startNavigationWithViewController:viewController];
            break;
        }
        case GHSNavigationRouteNavigationTypeTransition:
        {
            [self transitionFromCurrentViewControllerToViewController:viewController];
            break;
        }
        case GHSNavigationRouteNavigationTypePush:
        {
            [self pushViewController:viewController];
            break;
        }
        case GHSNavigationRouteNavigationTypePop:
        {
            [self popViewController];
            break;
        }
        default:
        {
            // Fallback
            [self startNavigationWithViewController:viewController];
            break;
        }
    }
}

- (void)startNavigationWithViewController:(UIViewController *)viewController
{
    self.currentViewController = viewController;
    [self.rootViewController addChildViewController:viewController];
    [self.rootViewController.containerView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self.rootViewController];
}

- (void)transitionFromCurrentViewControllerToViewController:(UIViewController *)toViewController
{
    [self.rootViewController addChildViewController:toViewController];
    [toViewController willMoveToParentViewController:self.rootViewController];
    
    UIViewController *fromViewController = self.currentViewController;
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromRight;
    [self.rootViewController transitionFromViewController:fromViewController
                                         toViewController:toViewController
                                                 duration:1.0f
                                                  options:options
                                               animations:nil
                                               completion:^(BOOL finished) {
                                                   self.currentViewController = toViewController;
                                                   [toViewController didMoveToParentViewController:self.rootViewController];
                                                   [fromViewController removeFromParentViewController];
                                               }];
}

- (void)pushViewController:(UIViewController *)viewController
{
    enforceControllerIsInstanceOf(self.currentViewController, [UINavigationController class]);
    UINavigationController *navigationController = (UINavigationController *)self.currentViewController;
    [navigationController pushViewController:viewController animated:YES];    
}

- (void)popViewController
{
    /*
     We let the navigation controller to control pop events. Otherwise we would need to provide a custom back button (which is easy) and
     manually handle the interactivePopGestuRerecognizer (which sounds pretty scary).
    
     It is ok to let the NavigationController handling this thing anyway, since the destination ViewModel is retained by the destination 
     ViewController, which in turn is retained by the UINavigationController. So the ViewModel should be still allocated, and the Navigator
     should be still observing its status. Since the ViewController is not in the screen, the status is set to DoneWithContext(whatever), 
     and it will be set back to DoingStuff in willActivate. And the world keeps turning.
    */
}

@end
