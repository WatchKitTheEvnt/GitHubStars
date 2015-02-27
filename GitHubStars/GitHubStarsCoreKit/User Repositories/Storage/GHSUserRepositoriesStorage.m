//
//  GHSUserRepositoriesStorage.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 14/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserRepositoriesStorage.h"
#import "GHSUserRepositories.h"
#import "GitHubStarsCoreKitConfiguration.h"

static NSString *const GHSUserRepositoriesStorageUserRepositoriesKey = @"GHSUserRepositoriesStorageUserRepositoriesKey";

@interface GHSUserRepositoriesStorage ()

@property (nonatomic) NSUserDefaults *sharedUserDefaults;

@end

@implementation GHSUserRepositoriesStorage

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:GitHubStarsCoreKitAppGroupName];
    }
    return self;
}

- (GHSUserRepositories *)loadUserRepositories
{
    NSData *userRepositoriesData = [self loadUserRepositoriesData];
    GHSUserRepositories *userRepositories = [GHSUserRepositories deserialize:userRepositoriesData];
    NSLog(@"%lu respoitories loaded", (unsigned long)[userRepositories.repositories count]);
    return userRepositories;
}

- (void)saveUserRepositories:(GHSUserRepositories *)userRepositories
{
    NSData *userRepositoriesData = [userRepositories serialize];
    [self saveUserRepositoriesData:userRepositoriesData];
    NSLog(@"%lu respoitories saved", (unsigned long)[userRepositories.repositories count]);
}

- (void)clearUserRepositories
{
    [self.sharedUserDefaults removeObjectForKey:GHSUserRepositoriesStorageUserRepositoriesKey];
    [self.sharedUserDefaults synchronize];
    NSLog(@"respoitories cache deleted");
}

#pragma mark - Private Loading / Saving

- (NSData *)loadUserRepositoriesData
{
    NSData *userRepositoriesData = [self.sharedUserDefaults objectForKey:GHSUserRepositoriesStorageUserRepositoriesKey];
    return userRepositoriesData;
}

- (void)saveUserRepositoriesData:(NSData *)userRepositoriesData
{
    [self.sharedUserDefaults setObject:userRepositoriesData forKey:GHSUserRepositoriesStorageUserRepositoriesKey];
}

@end
