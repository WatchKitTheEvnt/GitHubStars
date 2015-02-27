//
//  GHSStatefulUserRepositories.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSStatefulGetUserRepositories.h"

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import <WatchKit/WatchKit.h>
#import "GHSSharedKeys.h"

@implementation GHSStatefulGetUserRepositories

- (instancetype)initWithUserRepositoriesStorage:(GHSUserRepositoriesStorage *)userRepositoriesStorage
{
    self = [super init];
    if (self)
    {
        _userRepositoriesStorage = userRepositoriesStorage;
    }
    return self;
}

- (GHSUserRepositories *)loadUserRepositories
{
    return [self.userRepositoriesStorage loadUserRepositories];
}

- (void)loadUserRepositoriesWithCompletion:(GHSUserRepositoriesFetchCompletionBlock)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        GHSUserRepositories *loadedUserRepositories = [self loadUserRepositories];
        if (completion)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(loadedUserRepositories);
            });
        }
    });
}

- (void)fetchUserRepositoriesWithCompletion:(GHSUserRepositoriesFetchCompletionBlock)completion
{
    // Ask iOS App to fetch repositories for us
    NSDictionary *userInfo = @{GHSWatchKitExtensionRequestType : GHSWatchKitExtensionRequestTypeFetchUserRespoitories};
    [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"Received Response from containing iOS App");
        if (!error)
        {
            NSData *fetchedUserRepositoriesData = replyInfo[GHSContainingAppReplyFetchedUserRespoitories];
            GHSUserRepositories *fetchedUserRepositories = [GHSUserRepositories deserialize:fetchedUserRepositoriesData];
            if (fetchedUserRepositories && completion)
            {
                NSAssert([fetchedUserRepositories isKindOfClass:[GHSUserRepositories class]], @"Error deserializing user repsositories");
                completion(fetchedUserRepositories);
            }
        }
    }];
}

@end
