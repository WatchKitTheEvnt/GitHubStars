//
//  GHSRepository.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHSSerializableModel.h"

/** 
 GHSRepository is a PONSO object describing a repository.
 */
@interface GHSRepository : GHSSerializableModel

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *ownerLogin;
@property (nonatomic, copy, readonly) NSString *language;
@property (nonatomic, copy, readonly) NSString *shortDescription;
@property (nonatomic, copy, readonly) NSString *defaultBranch;
@property (nonatomic, readonly) NSDate *lastUpdate;
@property (nonatomic, readonly) NSUInteger forksCount;
@property (nonatomic, readonly) NSUInteger stargazersCount;
@property (nonatomic, readonly) NSUInteger openIssuesCount;

- (instancetype)initWithName:(NSString *)name
                  ownerLogin:(NSString *)ownerLogin
                    language:(NSString *)language
            shortDescription:(NSString *)shortDescription
               defaultBranch:(NSString *)defaultBranch
                  lastUpdate:(NSDate *)lastUpdate
                  forksCount:(NSUInteger)forksCount
             stargazersCount:(NSUInteger)stargazersCount
             openIssuesCount:(NSUInteger)openIssuesCount;

@end
