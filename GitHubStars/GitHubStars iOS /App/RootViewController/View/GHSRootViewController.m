//
//  GHSRootViewController.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 08/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSRootViewController.h"

#import "GHSRootViewModel.h"

@implementation GHSRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // ViewModel must be already available!
    NSAssert(self.viewModel, @"Before trying to present a %@ you must provide a valid ViewModel", NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.viewModel willActivate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.viewModel willDeactivate];
}

@end
