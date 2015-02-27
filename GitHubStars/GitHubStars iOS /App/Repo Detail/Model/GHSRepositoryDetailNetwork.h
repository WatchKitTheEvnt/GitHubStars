//
//  GHSRepositoryDetailNetwork.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 14/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class GHSRepository;
@class OCTClient;

@interface GHSRepositoryDetailNetwork : NSObject

@property (nonatomic, readonly) OCTClient *authenticatedClient;

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient;

/** 
 Fetches the readme of a GHSRepository in Markup format.
 Returns a signal which will send zero or one NSString *readmeMarkupContent.
 */
- (RACSignal *)fetchReadmeMarkupContentForRepository:(GHSRepository *)repository;

@end
