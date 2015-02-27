//
//  GHSAuthenticationEntityStub.m
//  GitHubSearch
//
//  Created by César Estébanez Tascón on 19/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSAuthenticationEntityStub.h"

#import <OctoKit/OctoKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GHSAuthenticationEntityStub ()

@property (nonatomic) OCTClient *authenticatedClientDummy;
@end

@implementation GHSAuthenticationEntityStub

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _authenticatedClientDummy = [[OCTClient alloc] initWithServer:OCTServer.dotComServer];
    }
    return self;
}

- (OCTClient *)tryAutomaticSignIn
{
    return self.authenticatedClientDummy;
}

- (RACSignal *)signInWithUsername:(NSString *)username password:(NSString *)password
{
    return [RACSignal return:self.authenticatedClientDummy];
}

- (void)clearAuthentication
{
    // Nothing to clear
}

@end
