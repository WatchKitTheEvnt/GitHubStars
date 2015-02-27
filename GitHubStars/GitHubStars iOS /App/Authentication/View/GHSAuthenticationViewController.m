//
//  GHSAuthenticationViewController.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 05/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSAuthenticationViewController.h"

#import "GHSAuthenticationViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GHSAuthenticationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *loginStatusLabel;

@end

@implementation GHSAuthenticationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // ViewModel must be already available!
    NSAssert(self.viewModel, @"Before trying to present a %@ you must provide a valid ViewModel", NSStringFromClass([self class]));
    [self bindViewModel];
    
    self.userTextField.delegate = self;
    self.passwordTextField.delegate = self;
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

- (void)bindViewModel
{
    self.signInButton.rac_command = self.viewModel.signInCommand;
    
    RAC(self.loginStatusLabel, text) = RACObserve(self.viewModel, currentStatusDescription);
    
    // Two way binding userTextField <--> viewModel.username
    RAC(self.viewModel, username) = self.userTextField.rac_textSignal;
    RAC(self.userTextField, text) = RACObserve(self.viewModel, username);
    
    // Two way binding passwordTextField <--> viewModel.password
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.passwordTextField, text) = RACObserve(self.viewModel, password);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
