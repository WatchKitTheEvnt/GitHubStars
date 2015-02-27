//
//  GHSReactiveGetUserRepositoriesStub.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 27/02/15.
//  Copyright (c) 2015 Tuenti Technologies. All rights reserved.
//

#import "GHSReactiveGetUserRepositoriesStub.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSFetchUserRepositories.h"
#import "GHSLoadUserRepositories.h"

@implementation GHSReactiveGetUserRepositoriesStub

- (RACSignal *)getUserRepositoriesWithRefreshSignal:(RACSignal *)refreshSignal
{
    return [self stubbedUserRepositoriesSignal];
}

- (RACSignal *)getUserRepositoriesSkippingCacheWithRefreshSignal:(RACSignal *)refreshSignal
{
    return [self stubbedUserRepositoriesSignal];
}

- (RACSignal *)stubbedUserRepositoriesSignal
{
    NSArray *stubbedRepositories = [self randomRepositoriesArray];
    GHSUserRepositories *stubbedUserRepositories = [[GHSUserRepositories alloc] initWithRepositories:stubbedRepositories];
    
    return [RACSignal return:stubbedUserRepositories];
}

- (NSArray *)randomRepositoriesArray
{
    GHSRepository *repositoryA = [[GHSRepository alloc] initWithName:@"repositoryA" ownerLogin:@"me" language:@"Objective-C" shortDescription:@"Description A" defaultBranch:@"master" lastUpdate:[NSDate date] forksCount:0 stargazersCount:0 openIssuesCount:0];
    GHSRepository *repositoryB = [[GHSRepository alloc] initWithName:@"repositoryB" ownerLogin:@"me" language:@"Swift" shortDescription:@"Description B" defaultBranch:@"master" lastUpdate:[NSDate date] forksCount:0 stargazersCount:0 openIssuesCount:0];
    
    return @[repositoryA, repositoryB];
}

@end
