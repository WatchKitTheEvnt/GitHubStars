//
//  GHSRepositoryDetailNetwork.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 14/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSRepositoryDetailNetwork.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <OctoKit/OCTRepository.h>
#import <OctoKit/OCTContent.h>
#import <OctoKit/OCTFileContent.h>
#import <OctoKit/OCTClient+Repositories.h>
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>

@interface GHSRepositoryDetailNetwork ()

@property (nonatomic) NSMutableDictionary *networkRepositoriesCache;

@end

@implementation GHSRepositoryDetailNetwork

- (instancetype)initWithAuthenticatedClient:(OCTClient *)authenticatedClient
{
    self = [super init];
    if (self)
    {
        _authenticatedClient = authenticatedClient;
    }
    return self;
}

- (RACSignal *)fetchReadmeMarkupContentForRepository:(GHSRepository *)repository
{
    OCTClient *authenticatedClient = self.authenticatedClient;
    
    return [[[[authenticatedClient
               fetchRepositoryWithName:repository.name owner:repository.ownerLogin]
               flattenMap:^RACStream *(OCTRepository *repository) {
                   return [authenticatedClient fetchRepositoryReadme:repository];
               }]
               catchTo:[RACSignal empty]]
               map:^NSString *(OCTFileContent *readme) {
                   NSString *markupContentAsBase64EncodedString = readme.content;
                   NSData *markupContentAsBase64EncodedData = [[NSData alloc] initWithBase64EncodedString:markupContentAsBase64EncodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
                   NSString *markupContent = [[NSString alloc] initWithData:markupContentAsBase64EncodedData encoding:NSUTF8StringEncoding];
                   return markupContent;
               }];
}

@end
