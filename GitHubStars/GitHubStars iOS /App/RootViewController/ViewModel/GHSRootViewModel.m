//
//  GHSRootViewModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 08/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSRootViewModel.h"

#import "GHSAuthenticationEntity.h"
#import "GHSViewModelStatus.h"

@interface GHSRootViewModel ()

@property (nonatomic) GHSAuthenticationEntity *authenticationEntity;

@end

@implementation GHSRootViewModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _authenticationEntity = [[GHSAuthenticationEntity alloc] init];
    }
    return self;
}

- (void)willActivate
{
    [super willActivate];
    
    OCTClient *authenticatedClient = [self.authenticationEntity tryAutomaticSignIn];
    if (authenticatedClient)
    {
        self.status = DoneWithContext(authenticatedClient);
    }
    else
    {
        self.status = DoneWithContext(self.authenticationEntity);
    }
}

@end
