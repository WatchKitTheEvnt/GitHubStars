//
//  GHSUserRepositoriesStorage+Reactive.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 14/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserRepositoriesStorage+Reactive.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation GHSUserRepositoriesStorage (Reactive)

- (RACSignal *)loadUserRepositoriesSignal
{
    @weakify(self);
    return [RACSignal startEagerlyWithScheduler:[RACScheduler scheduler] block:^(id<RACSubscriber> subscriber) {
        @strongify(self);
        GHSUserRepositories *userRepositories = [self loadUserRepositories];
        [subscriber sendNext:userRepositories];
        [subscriber sendCompleted];
    }];
}

@end
