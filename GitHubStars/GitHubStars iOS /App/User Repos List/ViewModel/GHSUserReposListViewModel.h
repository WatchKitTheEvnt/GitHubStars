//
//  GHSUserReposListViewModel.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 18/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHSViewModel.h"
#import "GHSUserInfoViewModel.h"

@class OCTClient;
@class GHSUserInfoViewModel;
@class RACCommand;
@class RACSignal;
@class GHSReactiveGetUserRepositories;

@interface GHSUserReposListViewModel : GHSViewModel

@property (nonatomic, readonly) RACSignal *userRepositoriesSignal;
@property (nonatomic, readonly) BOOL showRepositories;
@property (nonatomic, readonly) BOOL showSpinner;
@property (nonatomic, readonly) RACCommand *repoSelectedCommand;
@property (nonatomic, readonly) RACCommand *refreshCommand;

@property (nonatomic, readonly) GHSReactiveGetUserRepositories *getUserRepositories;
@property (nonatomic, readonly) GHSUserInfoViewModel *userInfoViewModel;
@property (nonatomic, readonly) OCTClient *authenticatedClient;

- (instancetype)initWithGetUserRepositories:(GHSReactiveGetUserRepositories *)getUserRepositories
                          userInfoViewModel:(GHSUserInfoViewModel *)userInfoViewModel
                        authenticatedClient:(OCTClient *)authenticatedClient;

@end
