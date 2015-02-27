//
//  GHSAuthentication.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 05/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSAuthenticationEntity.h"

#import "KeychainItemWrapper.h"
#import <OctoKit/OctoKit.h>
#import <ReactiveCocoa/RACEXTScope.h>

static NSString *const kKeychainCredentialsKey = @"GSHAuthenticationEntityCredentialsKey";
static NSString *const kClientID = @"616f9bd955a792c236b7";
static NSString *const kClientSecret = @"123938ef0d7422254ef31a1ac52a69a73d02db29";

@interface GHSAuthenticationEntity ()

@end

@implementation GHSAuthenticationEntity

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // Needed to start authentication process
        [OCTClient setClientID:kClientID clientSecret:kClientSecret];
    }
    return self;
}

- (OCTClient *)tryAutomaticSignIn
{
    // We can use access group to share information with WatchKit app (if needed)
    KeychainItemWrapper *credentials = [[KeychainItemWrapper alloc] initWithIdentifier:kKeychainCredentialsKey
                                                                           accessGroup:nil];
    NSString *rawLogin = [credentials objectForKey:(__bridge id)kSecAttrAccount];
    NSString *token = [credentials objectForKey:(__bridge id)kSecValueData];
    
    // When no matches in the keychain, we do not get nil, but empty strings
    if ((rawLogin.length != 0) && (token.length != 0))
    {
        return [self signInWithSavedLogin:rawLogin savedToken:token];
    }
    return nil;
}

- (OCTClient *)signInWithSavedLogin:(NSString *)savedLogin savedToken:(NSString *)savedToken
{
    OCTUser *savedUser = [OCTUser userWithRawLogin:savedLogin server:OCTServer.dotComServer];
    OCTClient *authenticatedClient = [OCTClient authenticatedClientWithUser:savedUser token:savedToken];
    return authenticatedClient;
}

- (RACSignal *)signInWithUsername:(NSString *)username password:(NSString *)password
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // Start authentication process using OCTClient. The events sent by the returned signal will be
        // processed and/or forwarded to subscriber when needed
        OCTUser *user = [OCTUser userWithRawLogin:username server:OCTServer.dotComServer];
        [[OCTClient signInAsUser:user password:password oneTimePassword:nil scopes:(OCTClientAuthorizationScopesUser|OCTClientAuthorizationScopesRepository) note:nil noteURL:nil fingerprint:nil]
         subscribeNext:^(OCTClient *authenticatedClient) {
             @strongify(self);
             NSString *rawLogin = authenticatedClient.user.rawLogin;
             NSString *token = authenticatedClient.token;
             [self storeRawLogin:rawLogin token:token];
             [subscriber sendNext:authenticatedClient];
         } error:^(NSError *error) {
             NSLog(@"OCTClient Error %@", error);
             [subscriber sendError:error];
         } completed:^{
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

- (void)clearAuthentication
{
    [self clearKeychain];
}

#pragma mark - KeyChain Management

- (void)storeRawLogin:(NSString *)rawLogin token:(NSString *)token
{
    // We can use access group to share information with WatchKit app (if needed)
    KeychainItemWrapper *credentials = [[KeychainItemWrapper alloc] initWithIdentifier:kKeychainCredentialsKey
                                                                           accessGroup:nil];
    [credentials setObject:rawLogin forKey:(__bridge id)kSecAttrAccount];
    [credentials setObject:token forKey:(__bridge id)kSecValueData];
    [credentials setObject:(__bridge id)(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly) forKey:(__bridge id)(kSecAttrAccessible)];
}

- (void)clearKeychain
{
    KeychainItemWrapper *credentials = [[KeychainItemWrapper alloc]
                                        initWithIdentifier:kKeychainCredentialsKey
                                        accessGroup:nil];
    [credentials resetKeychainItem];
}

@end
