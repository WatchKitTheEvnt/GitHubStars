//
//  GHSRepoDetailViewModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 24/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSRepoDetailViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSRepositoryDetailNetwork.h"

@interface GHSRepoDetailViewModel ()

@property (nonatomic) RACSignal *readmeMarkupContentSignal;
@property (nonatomic) RACSignal *stargazersCountSignal;
@property (nonatomic) RACSignal *forksCountSignal;
@property (nonatomic) RACSignal *openIssuesCountSignal;
@property (nonatomic) RACSignal *repositoryNameSignal;

@end

@implementation GHSRepoDetailViewModel

- (instancetype)initWithSelectedRepo:(GHSRepository *)selectedRepo repositoryDetailNetwork:(GHSRepositoryDetailNetwork *)repositoryDetailNetwork
{
    self = [super init];
    if (self)
    {
        _selectedRepo = selectedRepo;
        _repositoryDetailNetwork = repositoryDetailNetwork;
    }
    return self;
}

- (RACSignal *)repositoryNameSignal
{
    if (!_repositoryNameSignal)
    {
        _repositoryNameSignal = RACObserve(self.selectedRepo, name);
    }
    
    return _repositoryNameSignal;
}

- (RACSignal *)readmeMarkupContentSignal
{
    if (!_readmeMarkupContentSignal)
    {
        _readmeMarkupContentSignal = [[self.repositoryDetailNetwork fetchReadmeMarkupContentForRepository:self.selectedRepo]
                                      deliverOn:RACScheduler.mainThreadScheduler];
    }
    return _readmeMarkupContentSignal;
}

- (RACSignal *)stargazersCountSignal
{
    if (!_stargazersCountSignal)
    {
        _stargazersCountSignal = RACObserve(self.selectedRepo, stargazersCount);
    }
    return _stargazersCountSignal;
}

- (RACSignal *)forksCountSignal
{
    if (!_forksCountSignal)
    {
        _forksCountSignal = RACObserve(self.selectedRepo, forksCount);
    }
    return _forksCountSignal;
}

- (RACSignal *)openIssuesCountSignal
{
    if (!_openIssuesCountSignal)
    {
        _openIssuesCountSignal = RACObserve(self.selectedRepo, openIssuesCount);
    }
    return _openIssuesCountSignal;
}

@end
