//
//  GHSRepository.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSRepository.h"

static NSString *const GHSRepositoryNameKey = @"name";
static NSString *const GHSRepositoryOwnerLoginKey = @"ownerLogin";
static NSString *const GHSRepositoryLanguageKey = @"language";
static NSString *const GHSRepositoryShortDescriptionKey = @"shortDescription";
static NSString *const GHSRepositoryDefaultBranchKey = @"defaultBranch";
static NSString *const GHSRepositoryLastUpdateKey = @"lastUpdate";
static NSString *const GHSRepositoryForksCountKey = @"forksCount";
static NSString *const GHSRepositoryStargazersCountKey = @"stargazersCount";
static NSString *const GHSRepositoryOpenIssuesCountKey = @"openIssuesCount";

@implementation GHSRepository

- (instancetype)initWithName:(NSString *)name
                  ownerLogin:(NSString *)ownerLogin
                    language:(NSString *)language
            shortDescription:(NSString *)shortDescription
               defaultBranch:(NSString *)defaultBranch
                  lastUpdate:(NSDate *)lastUpdate
                  forksCount:(NSUInteger)forksCount
             stargazersCount:(NSUInteger)stargazersCount
             openIssuesCount:(NSUInteger)openIssuesCount
{
    self = [self init];
    if (self)
    {
        _name = [name copy];
        _ownerLogin = [ownerLogin copy];
        _language = [language copy];
        _shortDescription = [shortDescription copy];
        _defaultBranch = [defaultBranch copy];
        _lastUpdate = lastUpdate;
        _forksCount = forksCount;
        _stargazersCount = stargazersCount;
        _openIssuesCount = openIssuesCount;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self)
    {
        _name = [coder decodeObjectForKey:GHSRepositoryNameKey];
        _ownerLogin = [coder decodeObjectForKey:GHSRepositoryOwnerLoginKey];
        _language = [coder decodeObjectForKey:GHSRepositoryLanguageKey];
        _shortDescription = [coder decodeObjectForKey:GHSRepositoryShortDescriptionKey];
        _defaultBranch = [coder decodeObjectForKey:GHSRepositoryDefaultBranchKey];
        _lastUpdate = [coder decodeObjectForKey:GHSRepositoryLastUpdateKey];
        _forksCount = [[coder decodeObjectForKey:GHSRepositoryForksCountKey] unsignedIntegerValue];
        _stargazersCount = [[coder decodeObjectForKey:GHSRepositoryStargazersCountKey] unsignedIntegerValue];
        _openIssuesCount = [[coder decodeObjectForKey:GHSRepositoryOpenIssuesCountKey] unsignedIntegerValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:GHSRepositoryNameKey];
    [coder encodeObject:self.ownerLogin forKey:GHSRepositoryOwnerLoginKey];
    [coder encodeObject:self.language forKey:GHSRepositoryLanguageKey];
    [coder encodeObject:self.shortDescription forKey:GHSRepositoryShortDescriptionKey];
    [coder encodeObject:self.defaultBranch forKey:GHSRepositoryDefaultBranchKey];
    [coder encodeObject:self.lastUpdate forKey:GHSRepositoryLastUpdateKey];
    [coder encodeObject:@(self.forksCount) forKey:GHSRepositoryForksCountKey];
    [coder encodeObject:@(self.stargazersCount) forKey:GHSRepositoryStargazersCountKey];
    [coder encodeObject:@(self.openIssuesCount) forKey:GHSRepositoryOpenIssuesCountKey];
}

@end
