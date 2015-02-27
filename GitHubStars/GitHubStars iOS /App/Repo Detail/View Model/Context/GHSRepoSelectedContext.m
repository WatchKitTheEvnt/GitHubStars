//
//  GHSRepoSelectedContext.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 24/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSRepoSelectedContext.h"

@implementation GHSRepoSelectedContext

+ (instancetype)contextWithSelectedRepo:(GHSRepository *)selectedRepo authenticatedClient:(OCTClient *)authenticatedClient
{
    return [[self alloc] initWithSelectedRepo:selectedRepo authenticatedClient:authenticatedClient];
}

- (instancetype)initWithSelectedRepo:(GHSRepository *)selectedRepo authenticatedClient:(OCTClient *)authenticatedClient
{
    self = [super init];
    if (self)
    {
        _selectedRepo = selectedRepo;
        _authenticatedClient = authenticatedClient;
    }
    return self;
}

@end
