//
//  GSHAuthenticationViewModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 05/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSAuthenticationViewModel.h"

#import "GHSAuthenticationEntity.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <OctoKit/OCTClient.h>

@interface GHSAuthenticationViewModel ()

@property (nonatomic, copy) NSString *currentStatusDescription;
@property (nonatomic) RACCommand *signInCommand;
@property (nonatomic) RACSignal *signInEnabledSignal;

@end

@implementation GHSAuthenticationViewModel

- (instancetype)initWithAuthenticationEntity:(GHSAuthenticationEntity *)authenticationEntity
{
    self = [super init];
    if (self)
    {
        _authenticationEntity = authenticationEntity;
        _currentStatusDescription = @"Introduce GitHub credentials";
    }
    return self;
}

- (RACCommand *)signInCommand
{
    if (!_signInCommand)
    {
        @weakify(self);
        _signInCommand = [[RACCommand alloc] initWithEnabled:self.signInEnabledSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.authenticationEntity signInWithUsername:self.username password:self.password];
        }];
        [self bindToExecutionsOfSignInCommand:_signInCommand];
    }
    
    return _signInCommand;
}

- (RACSignal *)signInEnabledSignal
{
    if (!_signInEnabledSignal)
    {
        _signInEnabledSignal = [RACSignal
                                combineLatest:@[RACObserve(self, username), RACObserve(self, password)]
                                reduce:^(NSString *username, NSString *password) {
                                    return @(username.length > 0 && password.length > 0);
                                }];
    }
    
    return _signInEnabledSignal;
}

- (void)bindToExecutionsOfSignInCommand:(RACCommand *)signInCommand
{
    @weakify(self);
    [signInCommand.executionSignals subscribeNext:^(RACSignal *executionSignal) {
        [[executionSignal deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(OCTClient *authenticatedClient) {
            @strongify(self);
            self.status = DoneWithContext(authenticatedClient);
        }];
    }];
    
    [[signInCommand.errors deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSError *error) {
        @strongify(self);
        if ([self isConnectionFailedError:error])
        {
            self.currentStatusDescription = NSLocalizedString(@"No Internet connection!", @"No internet status description status");
        }
        else if ([self isAuthenticationFailedError:error])
        {
            self.currentStatusDescription = NSLocalizedString (@"Invalid Credentials!", @"Authentication invalid description status");
            self.password = @""; // clear password
        }
        else
        {
            self.currentStatusDescription = NSLocalizedString (@"Unknown error",@"Unknown description status");

        }
    }];
}

- (BOOL)isConnectionFailedError:(NSError *)error
{
    return ([error.domain isEqualToString:OCTClientErrorDomain] && error.code == OCTClientErrorConnectionFailed);
}

- (BOOL)isAuthenticationFailedError:(NSError *)error
{
    return ([error.domain isEqualToString:OCTClientErrorDomain] && error.code == OCTClientErrorAuthenticationFailed);
}

@end
