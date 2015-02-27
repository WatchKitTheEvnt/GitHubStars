//
//  GlanceController.m
//  GitHubStars WatchKit Extension
//
//  Created by César Estébanez Tascón on 27/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSGlanceController.h"

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import "GHSStatefulGetUserRepositories.h"
#import "GHSWatchKitExtensionHandOffKeys.h"

@interface GHSGlanceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *repoNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *starImage;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *stargazersCountLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *errorLabel;

@property (nonatomic) GHSStatefulGetUserRepositories *getUserRepositories;

@end

@implementation GHSGlanceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        GHSUserRepositoriesStorage *userRepositoriesStorage = [[GHSUserRepositoriesStorage alloc] init];
        _getUserRepositories = [[GHSStatefulGetUserRepositories alloc] initWithUserRepositoriesStorage:userRepositoriesStorage];
    }
    return self;
}

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];

    [self prepareInterfaceFromCachedModel];
    [self fetchUserRepositories];
}

- (void)willActivate
{
    [super willActivate];
}

- (void)didDeactivate
{
    [super didDeactivate];
}

- (void)prepareInterfaceFromCachedModel
{
    GHSUserRepositories *userRepositories = [self.getUserRepositories loadUserRepositories];
    GHSRepository *popularRepository = userRepositories.popularRepository;
    
    if (popularRepository)
    {
        [self showPopularRepository:popularRepository];
    }
    else
    {
        [self showAuthenticationError];
    }
}

- (void)showPopularRepository:(GHSRepository *)popularRepository
{
    [self.errorLabel setHidden:YES];
    [self.repoNameLabel setText:popularRepository.name];
    [self.stargazersCountLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long) popularRepository.stargazersCount]];
    
    // Update user activity so WatchApp can continue the activity
    [self updateUserActivityWithPopularRepository:popularRepository];
}

- (void)showAuthenticationError
{
    [self.titleLabel setHidden:YES];
    [self.repoNameLabel setHidden:YES];
    [self.starImage setHidden:YES];
    [self.stargazersCountLabel setHidden:YES];
    [self.errorLabel setHidden:NO];
}

- (void)fetchUserRepositories
{
    __weak GHSGlanceController *weakSelf = self;
    [self.getUserRepositories fetchUserRepositoriesWithCompletion:^(GHSUserRepositories *userRepositories) {
        GHSRepository *fetchedPopularRepo = userRepositories.popularRepository;
        if (fetchedPopularRepo)
        {
            [weakSelf showPopularRepository:fetchedPopularRepo];
        }
    }];
}

- (void)updateUserActivityWithPopularRepository:(GHSRepository *)popularRepository
{
    NSData *popularRepositoryData = [popularRepository serialize];
    [self updateUserActivity:GHSWKEPopularRepositoryUserActivity userInfo:@{GHSWKEPopularRepositoryData : popularRepositoryData} webpageURL:nil];
}

@end
