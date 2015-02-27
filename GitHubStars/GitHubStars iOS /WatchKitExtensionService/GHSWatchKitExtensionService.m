//
//  GHSWatchKitExtensionService.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 16/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWatchKitExtensionService.h"

#import <OctoKit/OctoKit.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import <GitHubStarsCommonsKit/GitHubStarsCommonsKit.h>
#import "GHSWatchKitExtensionServiceModule.h"
#import "GHSAuthenticationEntity.h"
#import "GHSReactiveGetUserRepositories.h"
#import "GHSReactiveGetUserPullRequest.h"
#import "GHSUserRepositories.h"

@implementation GHSWatchKitExtensionService

- (instancetype)initWithWatchKitExtensionServiceModule:(GHSWatchKitExtensionServiceModule *)watchKitExtensionServiceModule
{
    self = [super init];
    if (self)
    {
        _watchKitExtensionServiceModule = watchKitExtensionServiceModule;
    }
    return self;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    if ([userInfo[GHSWatchKitExtensionRequestType] isEqualToString:GHSWatchKitExtensionRequestTypeFetchUserRespoitories])
    {
        [self application:application handleFetchUserRepositoriesRequestWithReply:reply];
    }
    else if ([userInfo[GHSWatchKitExtensionRequestType] isEqualToString:GHSWatchKitExtensionRequestTypeFetchUserPullRequest])
    {
        NSDictionary *repositoryPullRequestInfo = userInfo[GHSWatchKitExtensionRequestValues];
        [self application:application handleFetchUserPullRequestRequestForRepositoryInfo:repositoryPullRequestInfo withReply:reply];
    }
    else
    {
        NSError *unknowRequestTypeError = [NSError errorWithDomain:GHSContainingAppReplyErrorDomain code:GHSContainingAppReplyErrorUnknownRequestType  userInfo:nil];
        reply(@{GHSContainingAppReplyError : unknowRequestTypeError});
    }
}

- (void)application:(UIApplication *)application handleFetchUserRepositoriesRequestWithReply:(void (^)(NSDictionary *))reply
{
    // Fetching will be done in background and could take a while
    UIBackgroundTaskIdentifier fecthBackgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
        NSError *cannotFetchInTimeError = [NSError errorWithDomain:GHSContainingAppReplyErrorDomain code:GHSContainingAppReplyErrorUnableToFetchInTime userInfo:nil];
        reply(@{GHSContainingAppReplyError : cannotFetchInTimeError});
    }];
    
    GHSAuthenticationEntity *authenticationEntity = [self.watchKitExtensionServiceModule authenticationEntity];
    OCTClient *authenticatedClient = [authenticationEntity tryAutomaticSignIn];
    
    if (authenticatedClient)
    {
        GHSReactiveGetUserRepositories *getUserRepositories = [self.watchKitExtensionServiceModule getUserRepositoriesInteractorWithAuthenticatedClient:authenticatedClient];
        [[getUserRepositories getUserRepositoriesSkippingCacheWithRefreshSignal:nil]
          subscribeNext:^(GHSUserRepositories *fetchedUserRepositories) {
              NSData *fetchedUserRepositoriesData = [fetchedUserRepositories serialize];
              reply(@{GHSContainingAppReplyFetchedUserRespoitories : fetchedUserRepositoriesData});
              [application endBackgroundTask:fecthBackgroundTask];
          }
          error:^(NSError *error) {
              reply(@{GHSContainingAppReplyError : error});
              [application endBackgroundTask:fecthBackgroundTask];
          }];
    }
    else
    {
        NSError *notAuthenticatedError = [NSError errorWithDomain:GHSContainingAppReplyErrorDomain code:GHSContainingAppReplyErrorNotAuthenticatedCode userInfo:nil];
        reply(@{GHSContainingAppReplyError : notAuthenticatedError});
        [application endBackgroundTask:fecthBackgroundTask];
    }
}

- (void)application:(UIApplication *)application handleFetchUserPullRequestRequestForRepositoryInfo:(NSDictionary *)repositoryInfo withReply:(void (^)(NSDictionary *))reply
{
    // Fetching will be done in background and could take a while
    UIBackgroundTaskIdentifier fecthBackgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
        NSError *cannotFetchInTimeError = [NSError errorWithDomain:GHSContainingAppReplyErrorDomain code:GHSContainingAppReplyErrorUnableToFetchInTime userInfo:nil];
        reply(@{GHSContainingAppReplyError : cannotFetchInTimeError});
    }];
    
    GHSAuthenticationEntity *authenticationEntity = [self.watchKitExtensionServiceModule authenticationEntity];
    OCTClient *authenticatedClient = [authenticationEntity tryAutomaticSignIn];
    
    if (authenticatedClient)
    {
        NSString *repositoryName = repositoryInfo[GHSWatchKitExtensionRequestValuePullRequestRepositoryName];
        NSString *repositoryOwner = repositoryInfo[GHSWatchKitExtensionRequestValuePullRequestRepositoryOwner];
        GHSReactiveGetUserPullRequest *getUserPullRequest = [self.watchKitExtensionServiceModule getUserPullRequestInteractorWithAuthenticatedClient:authenticatedClient];
        [[getUserPullRequest getUserPullRequestSkippingCacheWithRefreshSignal:nil forRepositoryName:repositoryName owner:repositoryOwner]
         subscribeNext:^(GHSUserPullRequest *fetchedUserPullRequest) {
             NSData *fetchedUserPullRequestData = [fetchedUserPullRequest serialize];
             reply(@{GHSContainingAppReplyFetchedUserPullRequest : fetchedUserPullRequestData});
             [application endBackgroundTask:fecthBackgroundTask];
         }
         error:^(NSError *error) {
             reply(@{GHSContainingAppReplyError : error});
             [application endBackgroundTask:fecthBackgroundTask];
         }];        
    }
    else
    {
        NSError *notAuthenticatedError = [NSError errorWithDomain:GHSContainingAppReplyErrorDomain code:GHSContainingAppReplyErrorNotAuthenticatedCode userInfo:nil];
        reply(@{GHSContainingAppReplyError : notAuthenticatedError});
        [application endBackgroundTask:fecthBackgroundTask];
    }
}

@end
