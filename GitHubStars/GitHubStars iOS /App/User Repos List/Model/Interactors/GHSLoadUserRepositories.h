//
//  GHSLoadUserRepositories.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 21/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class GHSUserRepositoriesStorage;

@interface GHSLoadUserRepositories : NSObject

@property (nonatomic, readonly) GHSUserRepositoriesStorage *userRepositoriesStorage;

- (instancetype)initWithUserRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage;

- (RACSignal *)loadUserRepositoriesSignal;

@end
