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

typedef NS_ENUM(NSUInteger, GHSRepositorySortingOptions)
{
    GHSRepositorySortingByStarGazersCount,
    GHSRepositorySortingByLastUpdate,
};

@interface GHSWatchMainInterfaceController() <GHSNotificationsMainControllerDelegate>

@property (weak, nonatomic) IBOutlet WKInterfaceTable *interfaceTable;

@property (nonatomic, strong) GHSStatefulGetUserRepositories *getUserRepositories;

@property (nonatomic, strong) NSArray *repositories;

@property (nonatomic) GHSNotificationMainController *mainNotificationsController;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

@property (nonatomic, assign) GHSRepositorySortingOptions sortingOptions;

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
    [self prepareInterface];
}

- (void)prepareInterface
{
    if ([self isLoaded]) return;
    
    [self setTitle:@"GHS"];
    
    GHSUserRepositories *userRepositories = [self.getUserRepositories loadUserRepositories];
    
    NSArray *repositories = userRepositories.repositories;
    
    [self refreshDataWithRepositories:repositories];
}

- (void)showAuthenticationRequired
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0U];
    [self.interfaceTable insertRowsAtIndexes:indexSet withRowType:GHSWatchMainInterfaceControllerNotAuthenticatedRowType];
    self.loaded = NO;
}

- (void)showZeroCase
{
    [self.interfaceTable setRowTypes:@[GHSWatchMainInterfaceControllerEmptyListRowType]];
    self.loaded = NO;
}

- (void)fetchUserRepositories
{
    __weak GHSWatchMainInterfaceController *weakSelf = self;
    [self.getUserRepositories fetchUserRepositoriesWithCompletion:^(GHSUserRepositories *userRepositories) {
        NSArray *repositories = userRepositories.repositories;
        
        __strong GHSWatchMainInterfaceController *strongSelf = weakSelf;
        [strongSelf refreshDataWithRepositories:repositories];
    }];
}

- (void)refreshDataWithRepositories:(NSArray *)repositories
{
    NSInteger listItemCount = [repositories count];
    
    NSArray *previousRepositories = self.repositories;
    self.repositories = [self sortRepositories:repositories];
    if (listItemCount > 0)
    {
        if ([previousRepositories count] == 0)
        {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [self.interfaceTable removeRowsAtIndexes:indexSet];
        }
        
        // Update the data to show all of the list items.
        [self.interfaceTable setNumberOfRows:listItemCount withRowType:GHSWatchMainInterfaceControllerListRowType];
        
        for (NSInteger idx = 0; idx < listItemCount; idx++) {
            [self configureRepositoryRowControllerAtIndex:idx];
        }
    }
    else if (self.repositories != nil)
    {
        [self showZeroCase];
        if (previousRepositories == nil)
        {
            [self fetchUserRepositories];
        }
    }
    else
    {
        [self showAuthenticationRequired];
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

- (NSArray *)sortRepositories:(NSArray *)repositories
{
    NSArray *sortedRepos;
    switch (self.sortingOptions) {
        case GHSRepositorySortingByStarGazersCount:
            sortedRepos = [repositories sortedArrayWithOptions:0U usingComparator:^NSComparisonResult(GHSRepository *repository1, GHSRepository *repository2) {
                return (repository1.stargazersCount > repository2.stargazersCount ? NSOrderedAscending : NSOrderedDescending);
            }];
            break;
        case GHSRepositorySortingByLastUpdate:
            sortedRepos = [repositories sortedArrayWithOptions:0U usingComparator:^NSComparisonResult(GHSRepository *repository1, GHSRepository *repository2) {
                return [repository2.lastUpdate compare:repository1.lastUpdate];
            }];
            break;
        default:
            sortedRepos = self.repositories;
            break;
    }
    
    return sortedRepos;
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

#pragma mark - Sorting

- (void)setSortingOptions:(GHSRepositorySortingOptions)sortingOptions
{
    if (_sortingOptions == sortingOptions) return;
    
    _sortingOptions = sortingOptions;
    [self refreshDataWithRepositories:_repositories];
}

#pragma mark - Menu actions

- (IBAction)refreshDataAction
{
    [self fetchUserRepositories];
}

- (IBAction)sortByStarGazersAction
{
    self.sortingOptions = GHSRepositorySortingByStarGazersCount;
}

- (IBAction)sortByLastUpdateAction
{
    self.sortingOptions = GHSRepositorySortingByLastUpdate;
}

@end

