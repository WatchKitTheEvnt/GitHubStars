//
//  GHSUserDefaultStorageCordinator.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserDefaultStorageCordinator.h"
#import "GitHubStarsCoreKitConfiguration.h"

static NSString *const GHSUserDefaultStorageCordinatorSynchronizeErrorDomain = @"GHSUserDefaultStorageCordinatorSynchronizeErrorDomain";
NSUInteger const GHSUserDefaultStorageCordinatorSynchronizeErrorCode = 0;


@interface GHSUserDefaultStorageCordinator ()

@property (nonatomic) NSUserDefaults *sharedUserDefaults;

@end

@implementation GHSUserDefaultStorageCordinator

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:GitHubStarsCoreKitAppGroupName];
    }
    return self;
}

- (void)saveSerializableModel:(GHSSerializableModel *)model forKey:(NSString *)key withCompletionHandler:(void (^)(NSError *error))completionHandler;
{
    NSData *data = [model serialize];
    [self.sharedUserDefaults setObject:data forKey:key];
    completionHandler([self synchronizeUserDefaults]);
}

- (void)loadSerializableModelForKey:(NSString *)key withCompletionHandler:(void (^)(GHSSerializableModel *model, NSError *error))completionHandler;
{
    NSData *dataLoaded = [self.sharedUserDefaults dataForKey:key];
    completionHandler([GHSSerializableModel deserialize:dataLoaded], nil);
}

- (void)clearSerializableModelForKey:(NSString *)key withCompletionHandler:(void (^)(NSError *error))completionHandler;
{
    [self.sharedUserDefaults removeObjectForKey:key];
    completionHandler([self synchronizeUserDefaults]);
}

#pragma mark - Private Method

- (NSError *)synchronizeUserDefaults
{
    BOOL synchronize = [self.sharedUserDefaults synchronize];
    NSError *error = nil;
    if (!synchronize)
    {
        error = [NSError errorWithDomain:GHSUserDefaultStorageCordinatorSynchronizeErrorDomain
                                    code:GHSUserDefaultStorageCordinatorSynchronizeErrorCode
                                userInfo:nil];
    }
    return error;
}


@end
