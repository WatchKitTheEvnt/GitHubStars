//
//  GHSLoadUserRepositories.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 21/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSLoadUserRepositories.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSUserRepositoriesStorage+Reactive.h"

@implementation GHSLoadUserRepositories

- (instancetype)initWithUserRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage
{
    self = [super init];
    if (self)
    {
        _userRepositoriesStorage = userRepositoriesStorage;
    }
    return self;
}

- (RACSignal *)loadUserRepositoriesSignal
{
    return [self.userRepositoriesStorage loadUserRepositoriesSignal];
}

@end
