//
//  GHSUserInfoViewModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 18/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSUserInfoViewModel.h"

#import <OctoKit/OctoKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "GHSUserRepositoriesStorage+Reactive.h"
#import "GHSAuthenticationEntity.h"

@interface GHSUserInfoViewModel ()

@property (nonatomic) RACSignal *userNameSignal;
@property (nonatomic) RACSignal *avatarURLSignal;
@property (nonatomic) RACSignal *fetchUserInfo;

@end

@implementation GHSUserInfoViewModel

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient
                       authenticationEntity:(GHSAuthenticationEntity *)authenticationEntity
                    userRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage
{
    self = [super init];
    if (self)
    {
        _authenticatedClient = authenticatedClient;
        _authenticationEntity = authenticationEntity;
        _userRepositoriesStorage = userRepositoriesStorage;
    }
    return self;
}

- (RACSignal *)userNameSignal
{
    if (!_userNameSignal)
    {
        _userNameSignal = [[self.fetchUserInfo
                            map:^NSString *(OCTUser *user) {
                                return user.name;
                            }]
                            deliverOn:RACScheduler.mainThreadScheduler];
    }
    return _userNameSignal;
}

- (RACSignal *)avatarURLSignal
{
    if (!_avatarURLSignal)
    {
        _avatarURLSignal = [[self.fetchUserInfo
                             map:^NSURL *(OCTUser *user) {
                                 return user.avatarURL;
                             }]
                             deliverOn:RACScheduler.mainThreadScheduler];
    }
    return _avatarURLSignal;
}

- (RACSignal *)fetchUserInfo
{
    if (!_fetchUserInfo)
    {
        _fetchUserInfo = [[[[self.authenticatedClient fetchUserInfo]
                            filter:^BOOL(OCTUser *user) {
                                return user != nil;
                            }]
                            catchTo:[RACSignal empty]]
                            replayLazily];
    }
    return _fetchUserInfo;
}

- (RACCommand *)signOutCommand
{
    GHSAuthenticationEntity *authenticationEntity = self.authenticationEntity;
    GHSUserRepositoriesStorage *userRepositoriesStorage = self.userRepositoriesStorage;
    
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [authenticationEntity clearAuthentication];
        [userRepositoriesStorage clearUserRepositories];
        self.status = DoneWithContext(self.authenticationEntity);
        return [RACSignal empty];
    }];
}

@end
