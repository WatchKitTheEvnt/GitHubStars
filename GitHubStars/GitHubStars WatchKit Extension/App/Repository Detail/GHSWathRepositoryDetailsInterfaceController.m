//
//  GHSWathRepositoryDetailsInterfaceController.m
//  GitHubStars
//
//  Created by Víctor on 21/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSWathRepositoryDetailsInterfaceController.h"

#import "GHSRepository.h"

@interface GHSWathRepositoryDetailsInterfaceController()

@property (nonatomic) GHSRepository *repository;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *languageLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lastUpdateLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *starGazesLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *forksLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *openIssuesLabel;

@end


@implementation GHSWathRepositoryDetailsInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSAssert([context isKindOfClass:[GHSRepository class]], @"Expected class of 'context' is GHSRepository");
    
    self.repository = context;
    [self setTitle:self.repository.name];
    [self setUpInterface];
}

- (void)setUpInterface
{
    [self.shortDescriptionLabel setText:self.repository.shortDescription];
    [self.languageLabel setText:self.repository.language];
    [self.lastUpdateLabel setText:self.repository.lastUpdate.description];
    
    [self.starGazesLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)self.repository.stargazersCount]];
    [self.forksLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)self.repository.forksCount]];
    [self.openIssuesLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)self.repository.openIssuesCount]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



