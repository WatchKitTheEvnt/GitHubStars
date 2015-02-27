//
//  GHSRepositoryRowController.m
//  GitHubStars
//
//  Created by Víctor on 17/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSRepositoryRowController.h"

@interface GHSRepositoryRowController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *respositoryLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *stargazersLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *forksLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *openIssuesLabel;

@end

@implementation GHSRepositoryRowController

- (void)setRepositoryName:(NSString *)repositoryName
{
    [self.respositoryLabel setText:repositoryName];
}

- (void)setStargazeCount:(NSUInteger)startgazeCount
{
    [self.stargazersLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)startgazeCount]];
}

- (void)setForksCount:(NSUInteger)forksCount
{
    [self.forksLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)forksCount]];
}

- (void)setOpenIssuesCount:(NSUInteger)openIssuesCount
{
    [self.openIssuesLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)openIssuesCount]];
}

@end
