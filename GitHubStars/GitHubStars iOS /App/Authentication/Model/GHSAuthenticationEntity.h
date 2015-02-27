//
//  GHSAuthenticationEntity.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 05/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCTClient;
@class RACSignal;

@interface GHSAuthenticationEntity : NSObject

/** 
 Try singing in using the credentials stored in the keychain. Returns an authenticated OCTClient if it was possible to sign in, nil otherwise. 
 */
- (OCTClient *)tryAutomaticSignIn;

/**
 Negotiate sign in with the GitHub API.
 */
- (RACSignal *)signInWithUsername:(NSString *)username password:(NSString *)password;

/**
 Clears the authentication info stored in the keychain.
 */
- (void)clearAuthentication;

@end
