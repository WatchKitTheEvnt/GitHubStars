//
//  GHSUserInfoViewModel.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 18/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GHSViewModel.h"

@class OCTClient;
@class GHSAuthenticationEntity;
@class GHSUserRepositoriesStorage;
@class RACCommand;
@class RACSignal;

@interface GHSUserInfoViewModel : GHSViewModel

/** Send NSSTring *userName on next, then complete */
@property (nonatomic, readonly) RACSignal *userNameSignal;

/** Send NSURL *avatarURL on next, then complete */
@property (nonatomic, readonly) RACSignal *avatarURLSignal;

/** Command to be executed on sing out event */
@property (nonatomic, readonly) RACCommand *signOutCommand;

@property (nonatomic, readonly) OCTClient *authenticatedClient;
@property (nonatomic, readonly) GHSAuthenticationEntity *authenticationEntity;
@property (nonatomic, readonly) GHSUserRepositoriesStorage *userRepositoriesStorage;

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient
                       authenticationEntity:(GHSAuthenticationEntity *)authenticationEntity
                    userRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage;

@end
