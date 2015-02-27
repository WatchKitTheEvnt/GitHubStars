//
//  GHSFetchUserRepositories.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 21/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class GHSUserRepositoriesNetwork;
@class GHSUserRepositoriesStorage;

@interface GHSFetchUserRepositories : NSObject

@property (nonatomic, readonly) GHSUserRepositoriesNetwork *userRepositoriesNetwork;

- (instancetype)initWithUserRepositoriesNetwork:(GHSUserRepositoriesNetwork *)userRepositoriesNetwork;

- (RACSignal *)fetchUserRepositoriesWithRefreshSignal:(RACSignal *)refreshSignal;

@end
