//
//  GHSWatchKitExtensionServiceModule.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 17/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHSAuthenticationEntity;
@class GHSReactiveGetUserRepositories;
@class GHSReactiveGetUserPullRequest;
@class OCTClient;

@interface GHSWatchKitExtensionServiceModule : NSObject

- (GHSAuthenticationEntity *)authenticationEntity;

- (GHSReactiveGetUserRepositories *)getUserRepositoriesInteractorWithAuthenticatedClient:(OCTClient *)authenticatedClient;

- (GHSReactiveGetUserPullRequest *)getUserPullRequestInteractorWithAuthenticatedClient:(OCTClient *)authenticatedClient;

@end
