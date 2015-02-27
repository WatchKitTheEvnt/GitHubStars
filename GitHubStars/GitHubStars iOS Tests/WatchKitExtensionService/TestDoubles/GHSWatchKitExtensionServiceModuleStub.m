//
//  GHSWatchKitExtensionServiceModuleStub.m
//  GitHubSearch
//
//  Created by César Estébanez Tascón on 19/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWatchKitExtensionServiceModuleStub.h"

#import "GHSAuthenticationEntityStub.h"
#import "GHSReactiveGetUserRepositoriesStub.h"

@implementation GHSWatchKitExtensionServiceModuleStub

- (GHSAuthenticationEntity *)authenticationEntity
{
    return [[GHSAuthenticationEntityStub alloc] init];
}

- (GHSReactiveGetUserRepositories *)getUserRepositoriesInteractorWithAuthenticatedClient:(OCTClient *)authenticatedClient
{
    return [[GHSReactiveGetUserRepositoriesStub alloc] initWithFetchUserRepositories:nil loadUserRepositories:nil userRepositoriesStorage:nil];
}

@end
