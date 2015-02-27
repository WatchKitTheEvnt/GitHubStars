//
//  GHSUserPullRequestDefaultStorage.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSPullRequestSyncStorage.h"
#import "GHSStorageCordinator.h"

@interface GHSUserPullRequestDefaultStorage : NSObject <GHSPullRequestSyncStorage>

@property (nonatomic, readonly) id<GHSStorageCordinator>storageCordinator;

- (instancetype)initWithStorageCordinator:(id<GHSStorageCordinator>)storageCordinator;

@end
