//
//  GHSMainInterfaceController.m
//  GitHubStars
//
//  Created by Víctor on 16/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWatchMainInterfaceController.h"
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>


#import "GHSRepository.h"
#import "GHSRepositoryRowController.h"
#import "GHSStatefulGetUserRepositories.h"
#import "GHSUserRepositories.h"
#import "GHSUserRepositoriesStorage.h"
#import "GHSWatchKitExtensionHandOffKeys.h"
#import "GHSWatchStoryboardConstants.h"

#import "GHSWatchKitNotificationsCollaborators.h"
#import "GHSNotificationMainController.h"
#import "GHSUserPullRequest.h"


@interface GHSWatchMainInterfaceController() <GHSNotificationsMainControllerDelegate>

@end

@implementation GHSWatchMainInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

@end

