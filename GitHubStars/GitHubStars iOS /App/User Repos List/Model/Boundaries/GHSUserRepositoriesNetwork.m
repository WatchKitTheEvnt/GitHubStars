//
//  GHSUserRepositoriesNetwork.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserRepositoriesNetwork.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <OctoKit/OCTClient+Repositories.h>
#import <OctoKit/OCTRepository.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

@implementation GHSUserRepositoriesNetwork

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient
{
    self = [super init];
    if (self)
    {
        _authenticatedClient = authenticatedClient;
    }
    return self;
}

- (RACSignal *)fetchUserRepositories
{
    return [[[[[self.authenticatedClient fetchUserRepositories]
             catchTo:[RACSignal empty]]
             map:^GHSRepository *(OCTRepository *repository) {
                 return [[GHSRepository alloc] initWithName:repository.name
                                                 ownerLogin:repository.ownerLogin
                                                   language:repository.language
                                           shortDescription:repository.repoDescription
                                              defaultBranch:repository.defaultBranch
                                                 lastUpdate:repository.dateUpdated
                                                 forksCount:repository.forksCount
                                            stargazersCount:repository.stargazersCount
                                            openIssuesCount:repository.openIssuesCount];
             }]
             collect]
             map:^GHSUserRepositories *(NSArray *repositories) {
                 NSLog(@"%lu repositories fetched", (unsigned long)[repositories count]);
                 return [[GHSUserRepositories alloc] initWithRepositories:repositories];
             }];
}

@end
