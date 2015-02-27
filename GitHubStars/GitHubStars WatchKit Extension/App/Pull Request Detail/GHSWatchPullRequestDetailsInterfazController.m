//
//  GHSPullRequestDetailInterfazController.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 25/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWatchPullRequestDetailsInterfazController.h"

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSWatchKitNotificationsCollaborators.h"
#import "GHSLoadPullRequestList.h"

@interface GHSWatchPullRequestDetailsInterfazController()

// Interfaz elements
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *bodyLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *userNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *updateDateLabel;

// Model
@property (nonatomic) GHSPullRequest *pullRequest;
@property (nonatomic, strong) GHSLoadPullRequestList *loadPullRequestList;

@end

@implementation GHSWatchPullRequestDetailsInterfazController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        GHSWatchKitNotificationsCollaborators *notificationsModuleCollaborators = [[GHSWatchKitNotificationsCollaborators alloc] init];
        _loadPullRequestList = [notificationsModuleCollaborators loadPullRequestListInteractor];
    }
    return self;
}

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    // Configure interface objects here.
   // NSAssert([context isKindOfClass:[GHSPullRequest class]], @"Expected class of 'context' is GHPullRequest");

    // Use the pullRequest we just fecth from network
   // self.pullRequest = context;
    
    //[self setUpInterface];
    
    // Uncomment this one to load from persistent
    [self loadPullRequestFromFileStorage];

}

- (void)willActivate
{
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate
{
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - Interfaz Elements

- (void)setUpInterface
{
    [self.titleLabel setText:self.pullRequest.title];
    [self.bodyLabel setText:self.pullRequest.body];
    [self.userNameLabel setText:self.pullRequest.userName];
    [self.updateDateLabel setText:[self.pullRequest.updatedDate description]];
}

#pragma mark - Retrieve From File Storage

- (void)loadPullRequestFromFileStorage
{
    __weak GHSWatchPullRequestDetailsInterfazController *weakSelf = self;

    [self.loadPullRequestList loadUserPullRequestWithCompletion:^(GHSUserPullRequest *pullRequestList) {
        NSLog(@"List of PullRequest from file storage %lu", (unsigned long)[pullRequestList.pullRequest count]);
        GHSPullRequest *latestPullRequest = [pullRequestList latestPullRequest];
        weakSelf.pullRequest = latestPullRequest;
        [weakSelf setUpInterface];
    }];
}


@end



