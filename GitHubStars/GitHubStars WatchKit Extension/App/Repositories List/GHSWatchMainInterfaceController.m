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

@property (weak, nonatomic) IBOutlet WKInterfaceTable *interfaceTable;

@property (nonatomic, strong) GHSStatefulGetUserRepositories *getUserRepositories;

@property (nonatomic, strong) NSArray *repositories;

@property (nonatomic) GHSNotificationMainController *mainNotificationsController;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

@end

@implementation GHSWatchMainInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        GHSUserRepositoriesStorage *userRepositoriesStorage = [[GHSUserRepositoriesStorage alloc] init];
        _getUserRepositories = [[GHSStatefulGetUserRepositories alloc] initWithUserRepositoriesStorage:userRepositoriesStorage];
        
        // Notifications collaborators
        GHSWatchKitNotificationsCollaborators *notificationsModuleCollaborators = [[GHSWatchKitNotificationsCollaborators alloc] init];
        _mainNotificationsController = [notificationsModuleCollaborators mainNotificationsController];
        _mainNotificationsController.delegate = self;
    }
    
    return self;
}

#pragma mark - Segues

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex
{
    if ([segueIdentifier isEqualToString:GHSWatchMainInterfaceControllerListSelectionSegue]) {
        GHSRepository *repository = self.repositories[rowIndex];
        
        return repository;
    }
    
    return nil;
}

#pragma mark -

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
}

- (void)willActivate
{
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self prepareInterface];
}

- (void)didDeactivate
{
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)prepareInterface
{
    if ([self isLoaded]) return;
    
    [self setTitle:@"GHS"];
    
    GHSUserRepositories *userRepositories = [self.getUserRepositories loadUserRepositories];
    
    NSArray *repositories = userRepositories.repositories;
    
    if (userRepositories == nil)
    {
        [self showAuthenticationRequired];
    }
    else if (repositories)
    {
        self.repositories = repositories;
        [self refreshData];
    }
    else
    {
        [self showZeroCase];
        [self fetchUserRepositories];
    }
}

- (void)showAuthenticationRequired
{
}

- (void)showZeroCase
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0U];
    [self.interfaceTable insertRowsAtIndexes:indexSet withRowType:GHSWatchMainInterfaceControllerNoRowType];
    self.loaded = NO;
}

- (void)fetchUserRepositories
{
    __weak GHSWatchMainInterfaceController *weakSelf = self;
    [self.getUserRepositories fetchUserRepositoriesWithCompletion:^(GHSUserRepositories *userRepositories) {
        NSArray *repositories = userRepositories.repositories;
        
        __strong GHSWatchMainInterfaceController *strongSelf = weakSelf;
        strongSelf.loaded = YES;
        strongSelf.repositories = repositories;
        [strongSelf refreshData];
    }];
}

- (void)refreshData
{
    NSInteger listItemCount = [self.repositories count];
    
    if (listItemCount > 0)
    {
        // Update the data to show all of the list items.
        [self.interfaceTable setNumberOfRows:listItemCount withRowType:@"RepositoryRowController"];
        
        for (NSInteger idx = 0; idx < listItemCount; idx++) {
            [self configureRepositoryRowControllerAtIndex:idx];
        }
    }
    else if (self.repositories != nil)
    {
        [self showAuthenticationRequired];
    }
    else
    {
        [self showZeroCase];
    }
    
    self.loaded = YES;
}

- (void)configureRepositoryRowControllerAtIndex:(NSInteger)index
{
    GHSRepositoryRowController *itemRowController = [self.interfaceTable rowControllerAtIndex:index];
    
    GHSRepository *repository = self.repositories[index];
    
    [itemRowController setRepositoryName:repository.name];
    [itemRowController setStargazeCount:repository.stargazersCount];
    [itemRowController setForksCount:repository.forksCount];
    [itemRowController setOpenIssuesCount:repository.openIssuesCount];
}

- (void)handleUserActivity:(NSDictionary *)userInfo {
    NSData *popularRepositoryData = userInfo[GHSWKEPopularRepositoryData];
    if (popularRepositoryData != nil)
    {
        
        GHSRepository *popularRepository = [GHSRepository deserialize:popularRepositoryData];
        [self pushControllerWithName:GHSWathRepositoryDetailsInterfaceController context:popularRepository];
        return;
    }
}

#pragma mark - Notifications Handling

// when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification
{
    [self.mainNotificationsController handleActionWithIdentifier:identifier forRemoteNotification:remoteNotification];
}

// when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification
{
    [self.mainNotificationsController handleActionWithIdentifier:identifier forLocalNotification:localNotification];
}

#pragma mark - Notification Controller Delegate

- (void)notificationsMainController:(GHSNotificationMainController *)mainController didUpdateUserRepository:(GHSRepository *)repository
{
    NSLog(@"Repository to show detail %@", repository.name);
    // Load repo detail
    [self pushControllerWithName:GHSWathRepositoryDetailsInterfaceController context:repository];
}

- (void)notificationsMainController:(GHSNotificationMainController *)mainController didUpdatePullRequest:(GHSPullRequest *)pullRequest
{
    NSLog(@"PullRequest to show detail %@", pullRequest.body);
    [self presentControllerWithName:GHSWathPullRequestDetailsInterfaceController context:pullRequest];
}


@end



