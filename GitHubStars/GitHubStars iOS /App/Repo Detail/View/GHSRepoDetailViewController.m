//
//  GHSRepoDetailViewController.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 22/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSRepoDetailViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GHMarkdownParser/NSString+GHMarkdownParser.h>

@interface GHSRepoDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *readmeWebView;
@property (nonatomic) NSString *readmeHTMLContent;

@property (weak, nonatomic) IBOutlet UILabel *stargazersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *forksCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *openIssuesCountLabel;

@end

@implementation GHSRepoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // ViewModel must be already available!
    NSAssert(self.viewModel, @"Before trying to present a %@ you must provide a valid ViewModel", NSStringFromClass([self class]));
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [self.viewModel willActivate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.viewModel willDeactivate];
}

- (void)bindViewModel
{
    RAC(self, title) = self.viewModel.repositoryNameSignal;
    
    RAC(self, readmeHTMLContent) = [self.viewModel.readmeMarkupContentSignal
                                    map:^NSString *(NSString *markupContent) {
                                        NSString *htmlContent = markupContent.flavoredHTMLStringFromMarkdown;
                                        return htmlContent;
                                    }];
    
    RAC(self.stargazersCountLabel, text) = [self.viewModel.stargazersCountSignal
                                            map:^NSString *(NSNumber *stargazersCount) {
                                                return [NSString localizedStringWithFormat:@"%@", stargazersCount];
                                            }];
    RAC(self.forksCountLabel, text) = [self.viewModel.forksCountSignal
                                       map:^NSString *(NSNumber *forksCount) {
                                           return [NSString localizedStringWithFormat:@"%@", forksCount];
                                           
                                       }];
    RAC(self.openIssuesCountLabel, text) = [self.viewModel.openIssuesCountSignal
                                            map:^NSString *(NSNumber *openIssuesCount) {
                                                return [NSString localizedStringWithFormat:@"%@", openIssuesCount];
                                            }];
}

- (void)setReadmeHTMLContent:(NSString *)readmeHTMLContent
{
    if (_readmeHTMLContent != readmeHTMLContent)
    {
        _readmeHTMLContent = readmeHTMLContent;
        [self.readmeWebView loadHTMLString:readmeHTMLContent baseURL:nil];
    }
}

@end
