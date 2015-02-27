//
//  GHSAuthenticationViewModel.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 05/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSViewModel.h"

@class RACCommand;
@class GHSAuthenticationEntity;

@interface GHSAuthenticationViewModel : GHSViewModel

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, readonly) RACCommand *signInCommand;
@property (nonatomic, copy, readonly) NSString *currentStatusDescription;

// The authentication entity used by the ViewModel to perform authentication
@property (nonatomic, readonly) GHSAuthenticationEntity *authenticationEntity;

- (instancetype)initWithAuthenticationEntity:(GHSAuthenticationEntity *)authenticationEntity;

@end
