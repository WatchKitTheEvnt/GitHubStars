//
//  GHSRepoSelectedContext.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 24/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHSRepository;
@class OCTClient;

@interface GHSRepoSelectedContext : NSObject

@property (nonatomic) GHSRepository *selectedRepo;
@property (nonatomic) OCTClient *authenticatedClient;

+ (instancetype)contextWithSelectedRepo:(GHSRepository *)selectedRepo authenticatedClient:(OCTClient *)authenticatedClient;

@end
