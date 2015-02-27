//
//  GHSNotificationService.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSNotificationMainController.h"
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSRepository.h"
#import "GHSSharedKeys.h"


static NSString *const GHSNotificationPullRequestCategoryKey = @"PullRequestCategory";
static NSString *const GHSNotificationPullRequestRepositoryNameKey = @"pullRequestRepositoryName";
static NSString *const GHSNotificationPullRequestRepositoryOwnerKey = @"pullRequestRepositoryOwner";


static NSString *const GHSNotificationNewStarCategoryKey = @"NewStarCategory";
static NSString *const GHSNotificationNewStarRepositoryNameKey = @"repositoryName";



@interface GHSNotificationMainController ()

@property (nonatomic) GHSStatefulGetUserRepositories *getUserRepositories;
@property (nonatomic) GHSFetchPullRequestList *fetchPullRequest;

@end

@implementation GHSNotificationMainController

- (instancetype)initWithUserRepositoriesInteractor:(GHSStatefulGetUserRepositories *)getUserRepositories fectPullRequestInteractor:(GHSFetchPullRequestList *)fetchPullRequest
{
    self = [super init];
    if (self)
    {
        _getUserRepositories = getUserRepositories;
        _fetchPullRequest = fetchPullRequest;
    }
    return self;
}

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification
{
    NSString *category = remoteNotification[@"aps"][@"category"];
    if ([category isEqualToString:GHSNotificationPullRequestCategoryKey])
    {
        NSString *pullRequestRepositoryName = remoteNotification[GHSNotificationPullRequestRepositoryNameKey];
        NSString *pullRequestRepositoryOwner = remoteNotification[GHSNotificationPullRequestRepositoryOwnerKey];
        [self fetchPullRequestForRepositoryName:pullRequestRepositoryName repositoryOwner:pullRequestRepositoryOwner];
    }
    else if ([category isEqualToString:GHSNotificationNewStarCategoryKey])
    {
        NSString *repositoryName = remoteNotification[GHSNotificationNewStarRepositoryNameKey];
        [self fetchUserRepositorieWithName:repositoryName];
    }
}

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification
{
    NSDictionary *localInfo = [localNotification userInfo];
    NSString *repositoryName = localInfo[GHSNewStarLocalNotificationKey];
    [self fetchUserRepositorieWithName:repositoryName];
}

#pragma mark - 

- (void)fetchUserRepositorieWithName:(NSString *)name
{
    __weak GHSNotificationMainController *weakSelf = self;
    [self.getUserRepositories fetchUserRepositoriesWithCompletion:^(GHSUserRepositories *userRepositories) {
        GHSRepository *staredRepository = [userRepositories repositoryWithName:name];
        if ([weakSelf.delegate respondsToSelector:@selector(notificationsMainController:didUpdateUserRepository:)])
        {
            [weakSelf.delegate notificationsMainController:weakSelf didUpdateUserRepository:staredRepository];
        }
    }];
}

- (void)fetchPullRequestForRepositoryName:(NSString *)repositoryName repositoryOwner:(NSString *)repositoryOwner
{
    __weak GHSNotificationMainController *weakSelf = self;
    [self.fetchPullRequest fecthUserPullRequestForRepositoryName:repositoryName repositoryOwner:repositoryOwner withCompletion:^(GHSUserPullRequest *pullRequestList) {
        GHSPullRequest *latestPullRequest = [pullRequestList latestPullRequest];
        if ([weakSelf.delegate respondsToSelector:@selector(notificationsMainController:didUpdatePullRequest:)])
        {
            [weakSelf.delegate notificationsMainController:weakSelf didUpdatePullRequest:latestPullRequest];
        }
    }];
}

@end
