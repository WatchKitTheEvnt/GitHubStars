//
//  GHSUserRepositoriesStorage+Reactive.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 14/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserRepositoriesStorage.h"

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

@class RACSignal;

@interface GHSUserRepositoriesStorage (Reactive)

- (RACSignal *)loadUserRepositoriesSignal;

@end
