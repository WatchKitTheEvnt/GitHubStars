//
//  GHSRepoDetailViewModel.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 24/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSViewModel.h"

@class GHSRepository;
@class GHSRepositoryDetailNetwork;
@class RACSignal;

@interface GHSRepoDetailViewModel : GHSViewModel

// Sends an NSString with the name of the repository, then completes
@property (nonatomic, readonly) RACSignal *repositoryNameSignal;
// Sends an NSString with the contents of the README in Markup format, then completes
@property (nonatomic, readonly) RACSignal *readmeMarkupContentSignal;
// Sends an NSUInteger with the stargazersCount each time it changes
@property (nonatomic, readonly) RACSignal *stargazersCountSignal;
// Sends an NSUInteger wiht the forks count each time it changes
@property (nonatomic, readonly) RACSignal *forksCountSignal;
// Sends an NSUInteger wiht the open issues count each time it changes
@property (nonatomic, readonly) RACSignal *openIssuesCountSignal;

@property (nonatomic, readonly) GHSRepository *selectedRepo;
@property (nonatomic, readonly) GHSRepositoryDetailNetwork *repositoryDetailNetwork;

- (instancetype)initWithSelectedRepo:(GHSRepository *)selectedRepo repositoryDetailNetwork:(GHSRepositoryDetailNetwork *)repositoryDetailNetwork;

@end
