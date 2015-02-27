//
//  GHSUserRepositoriesStorage.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 14/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHSUserRepositories;

@interface GHSUserRepositoriesStorage : NSObject

- (GHSUserRepositories *)loadUserRepositories;

- (void)saveUserRepositories:(GHSUserRepositories *)userRepositories;

- (void)clearUserRepositories;

@end
