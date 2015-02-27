//
//  GHSUserRepositories.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserRepositories.h"

#import "GHSRepository.h"

static NSString *const GHSUserRepositoriesListKey = @"repositories";

@interface GHSUserRepositories ()

@property (nonatomic) GHSRepository *popularRepository;

@end

@implementation GHSUserRepositories

- (instancetype)initWithRepositories:(NSArray *)repositories
{
    self = [self init];
    if (self)
    {
        _repositories = repositories;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self)
    {
        _repositories  = [coder decodeObjectForKey:GHSUserRepositoriesListKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.repositories forKey:GHSUserRepositoriesListKey];
}

- (GHSRepository *)popularRepository
{
    if (!_popularRepository)
    {
        for (GHSRepository *repository in _repositories)
        {
            if (!_popularRepository || _popularRepository.stargazersCount < repository.stargazersCount)
            {
                _popularRepository = repository;
            }
        }
    }
    return _popularRepository;
}

- (GHSRepository *)repositoryWithName:(NSString *)name
{
    if ([self.popularRepository.name isEqualToString:name])
    {
        return self.popularRepository;
    }
    
    GHSRepository *repository = nil;
    for(GHSRepository *localRepository in _repositories)
    {
        if ([localRepository.name isEqualToString:name])
        {
            repository = localRepository;
            break;
        }
    }
    return repository;
}

@end
