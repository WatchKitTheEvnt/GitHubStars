//
//  GHSWatchKitNotificationsCollaborators.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWatchKitNotificationsCollaborators.h"
#import "GHSNotificationMainController.h"
#import "GHSStatefulGetUserRepositories.h"
#import "GHSUserRepositoriesStorage.h"

#import "GHSUserPullRequestDefaultStorage.h"
#import "GHSUserPullRequestFileStorage.h"

#import "GHSUserDefaultStorageCordinator.h"
#import "GHSFileStorageCordinator.h"
#import "GHSFetchPullRequestList.h"
#import "GHSLoadPullRequestList.h"

@implementation GHSWatchKitNotificationsCollaborators

#pragma mark - UserRepositories

- (id)mainNotificationsController
{
    return [[GHSNotificationMainController alloc] initWithUserRepositoriesInteractor:[self statefulGetUserRepositoriesInteractor] fectPullRequestInteractor:[self fetchPullRequestListInteractor]];
}

- (id)statefulGetUserRepositoriesInteractor
{
    return [[GHSStatefulGetUserRepositories alloc] initWithUserRepositoriesStorage:[self userRepositoriesStorage]];
}

- (id)userRepositoriesStorage
{
    return [[GHSUserRepositoriesStorage alloc] init];
}

#pragma mark - Storage Cordinators

- (id)userDefaultStorageCordinator
{
    return [[GHSUserDefaultStorageCordinator alloc] init];
}

- (id)fileStorageCordinator
{
    return [[GHSFileStorageCordinator alloc] init];
}

#pragma mark - PullRequest Storage Definitions

- (id)userPullRequestFileStorage
{
    return [[GHSUserPullRequestFileStorage alloc] initWithStorageCordinator:[self fileStorageCordinator]];
}

- (id)userPullRequestDefaultStorage
{
    return [[GHSUserPullRequestDefaultStorage alloc] initWithStorageCordinator:[self userDefaultStorageCordinator]];
}

#pragma mark - PullRequest Interactors

- (id)fetchPullRequestListInteractor
{
    return [[GHSFetchPullRequestList alloc] init];
}

- (id)loadPullRequestListInteractor
{
    return [[GHSLoadPullRequestList alloc] initWithPullRequestSyncStorage:[self userPullRequestDefaultStorage]
                                                             asyncStorage:[self userPullRequestFileStorage]];
}


@end
