//
//  GHSUserRepositories.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHSSerializableModel.h"

@class GHSRepository;

/**
 Represents a list of GHSRepository objects.
 */
@interface GHSUserRepositories : GHSSerializableModel

/** Array of GHSRepository objects */
@property (nonatomic, readonly) NSArray *repositories;

/** The most popular repository of the user (i.e. the one with more stargazers) */
@property (nonatomic, readonly) GHSRepository *popularRepository;

- (instancetype)initWithRepositories:(NSArray *)repositories;

- (GHSRepository *)repositoryWithName:(NSString *)name;

@end
