//
//  GHSWatchKitExtensionServiceModule.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 17/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWatchKitExtensionServiceModule.h"

#import <OctoKit/OctoKit.h>
#import "GHSAuthenticationEntity.h"
#import "GHSReactiveGetUserRepositories.h"
#import "GHSUserRepositoriesStorage+Reactive.h"
#import "GHSUserRepositoriesNetwork.h"
#import "GHSFetchUserRepositories.h"
#import "GHSLoadUserRepositories.h"

#import "GHSUserPullRequestNetwork.h"
#import "GHSReactiveGetUserPullRequest.h"
#import "GHSFetchUserPullRequest.h"

@implementation GHSWatchKitExtensionServiceModule

- (GHSAuthenticationEntity *)authenticationEntity
{
    return [[GHSAuthenticationEntity alloc] init];
}

- (GHSReactiveGetUserRepositories *)getUserRepositoriesInteractorWithAuthenticatedClient:(OCTClient *)authenticatedClient
{
    GHSUserRepositoriesNetwork *userRepositoriesNetwork = [[GHSUserRepositoriesNetwork alloc] initWithAuthenticatedClient:authenticatedClient];
    GHSUserRepositoriesStorage *userRepositoriesStorage = [[GHSUserRepositoriesStorage alloc] init];
    GHSFetchUserRepositories *fetchUserRepositories = [[GHSFetchUserRepositories alloc] initWithUserRepositoriesNetwork:userRepositoriesNetwork];
    GHSLoadUserRepositories *loadUserRepositories = [[GHSLoadUserRepositories alloc] initWithUserRepositoriesStorage:userRepositoriesStorage];
    GHSReactiveGetUserRepositories *getUserRepositories = [[GHSReactiveGetUserRepositories alloc] initWithFetchUserRepositories:fetchUserRepositories loadUserRepositories:loadUserRepositories userRepositoriesStorage:userRepositoriesStorage];
    return getUserRepositories;
}

- (GHSReactiveGetUserPullRequest *)getUserPullRequestInteractorWithAuthenticatedClient:(OCTClient *)authenticatedClient
{
    GHSUserPullRequestNetwork *userPullRequestNetwork = [[GHSUserPullRequestNetwork alloc] initWithAuthenticatedClient:authenticatedClient];
    GHSFileStorageCordinator *fileStorageCordinator = [[GHSFileStorageCordinator alloc] init];
    GHSUserPullRequestFileStorage *userPullRequestStorage = [[GHSUserPullRequestFileStorage alloc] initWithStorageCordinator:fileStorageCordinator];
    GHSFetchUserPullRequest *fetchUserPullRequest = [[GHSFetchUserPullRequest alloc] initWithUserPullRequestNetwork:userPullRequestNetwork];
    GHSReactiveGetUserPullRequest *getUserPullRequest = [[GHSReactiveGetUserPullRequest alloc] initWithFetchUserPullRequest:fetchUserPullRequest userPullRequestFileStorage:userPullRequestStorage];
    return getUserPullRequest;
}

@end
