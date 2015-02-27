//
//  GHSUserPullRequestNetwork.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 24/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserPullRequestNetwork.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <OctoKit/OCTClient+Repositories.h>
#import <OctoKit/OCTPullRequest.h>
#import <OctoKit/OCTUser.h>
#import <OctoKit/OCTRepository.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

@implementation GHSUserPullRequestNetwork

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient
{
    self = [super init];
    if (self)
    {
        _authenticatedClient = authenticatedClient;
    }
    return self;
}

- (RACSignal *)fetchUserPullRequestForRepositoryName:(NSString *)repositoryName owner:(NSString *)owner
{
    return [[[[[self.authenticatedClient fetchOpenPullRequestsForRepositoryWithName:repositoryName owner:owner]
               catchTo:[RACSignal empty]]
              map:^GHSPullRequest *(OCTPullRequest *pullRequest) {
                  return [[GHSPullRequest alloc] initWithTitle:pullRequest.title
                                                          body:pullRequest.body
                                                      userName:pullRequest.user.name
                                                         state:GHSPullRequestStateOpen
                                                       diffURL:pullRequest.diffURL
                                                baseRepository:[self repositoryForBaseRepository:pullRequest.baseRepository]
                                                   updatedDate:pullRequest.updatedDate];
              }]
             collect]
            map:^GHSUserPullRequest *(NSArray *pullRequestList) {
                NSLog(@"%lu pullRequestList fetched", (unsigned long)[pullRequestList count]);
                return [[GHSUserPullRequest alloc] initWithPullRequest:pullRequestList];
            }];
}

- (GHSRepository *)repositoryForBaseRepository:(OCTRepository *)baseRepository
{
    return [[GHSRepository alloc] initWithName:baseRepository.name
                                    ownerLogin:baseRepository.ownerLogin
                                      language:baseRepository.language
                              shortDescription:baseRepository.repoDescription
                                 defaultBranch:baseRepository.defaultBranch
                                    lastUpdate:baseRepository.dateUpdated
                                    forksCount:baseRepository.forksCount
                               stargazersCount:baseRepository.stargazersCount
                               openIssuesCount:baseRepository.openIssuesCount];
}

@end
