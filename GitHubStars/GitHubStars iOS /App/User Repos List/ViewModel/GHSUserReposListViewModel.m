//
//  GHSUserReposListViewModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 18/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSUserReposListViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSRepoSelectedContext.h"
#import "GHSReactiveGetUserRepositories.h"

@interface GHSUserReposListViewModel ()

@property (nonatomic) NSArray *userRepositories;
@property (nonatomic) BOOL showRepositories;
@property (nonatomic) BOOL showSpinner;
@property (nonatomic) RACCommand *repoSelectedCommand;
@property (nonatomic) RACCommand *refreshCommand;

@end

@implementation GHSUserReposListViewModel

- (instancetype)initWithGetUserRepositories:(GHSReactiveGetUserRepositories *)getUserRepositories
                          userInfoViewModel:(GHSUserInfoViewModel *)userInfoViewModel
                        authenticatedClient:(OCTClient *)authenticatedClient
{
    self = [super init];
    if (self)
    {
        _getUserRepositories = getUserRepositories;
        [self bindGetUserRepositories];
        _userInfoViewModel = userInfoViewModel;
        [self bindUserInfoViewModel];
        _authenticatedClient = authenticatedClient;
    }
    return self;
}

- (void)bindGetUserRepositories
{
    @weakify(self);
    _userRepositoriesSignal = [[[[[self.getUserRepositories
                                   getUserRepositoriesWithRefreshSignal:self.refreshCommand.executionSignals]
                                   startWith:nil]
                                   map:^NSArray *(GHSUserRepositories *userRepositories) {
                                       return userRepositories.repositories;
                                   }]
                                   deliverOn:RACScheduler.mainThreadScheduler]
                                   doNext:^(NSArray *userRepositories) {
                                       @strongify(self);
                                       self.showRepositories = (userRepositories != nil);
                                       self.showSpinner = (userRepositories == nil);
                                   }];
}

- (void)bindUserInfoViewModel
{
    RAC(self, status) = RACObserve(_userInfoViewModel, status);
}

- (void)willActivate
{
    [self.userInfoViewModel willActivate];
}

- (void)willDeactivate
{
    [self.userInfoViewModel willDeactivate];
}

- (RACCommand *)repoSelectedCommand
{
    if (!_repoSelectedCommand)
    {
        @weakify(self);
        _repoSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(GHSRepository *selectedRepo) {
            @strongify(self);
            GHSRepoSelectedContext *context = [GHSRepoSelectedContext contextWithSelectedRepo:selectedRepo authenticatedClient:self.authenticatedClient];
            self.status = DoneWithContext(context);
            return [RACSignal empty];
        }];
    }
    return _repoSelectedCommand;
}

- (RACCommand *)refreshCommand
{
    if (!_refreshCommand)
    {
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
    }
    return _refreshCommand;
}

@end
