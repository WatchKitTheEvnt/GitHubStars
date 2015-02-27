//
//  GHSUserReposListViewController.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 17/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSUserReposListViewController.h"

#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/UIRefreshControl+RACCommandSupport.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "GHSRepositoryCell.h"

@interface GHSUserReposListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *repositoriesListTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *userReposListSpinner;
@property (nonatomic) BOOL shouldShowSpinner;
@property (nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@property (nonatomic) NSArray *userRepos;

@end

@implementation GHSUserReposListViewController

static NSString * const kUserRepoCellReuseIdentifier = @"GHSUserRepoCollectionViewCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add pull-to-refresh control to CollectionView
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.repositoriesListTable addSubview:self.refreshControl];
    
    self.userAvatarImageView.layer.cornerRadius = self.userAvatarImageView.bounds.size.width / 2.f;
    self.userAvatarImageView.clipsToBounds = YES;
    
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
    // spinner
    RAC(self, shouldShowSpinner, @YES) = RACObserve(self.viewModel, showSpinner);
    
    // collectionView
    RAC(self.repositoriesListTable, hidden, @YES) = [RACObserve(self.viewModel, showRepositories) not];
    RAC(self, userRepos) = self.viewModel.userRepositoriesSignal;
    
    // refreshControl
    self.refreshControl.rac_command = self.viewModel.refreshCommand;
    
    [self bindUserInfoViewModel];
}

- (void)bindUserInfoViewModel
{
    RAC(self.userAvatarImageView, image) = [self.viewModel.userInfoViewModel.avatarURLSignal
                                            map:^UIImage *(NSURL *avatarURL) {
                                                return [UIImage imageWithData:[NSData dataWithContentsOfURL:avatarURL]];
                                            }];
    
    self.signOutButton.rac_command = self.viewModel.userInfoViewModel.signOutCommand;
}

- (void)setShouldShowSpinner:(BOOL)shouldShowSpinner
{
    if (_shouldShowSpinner != shouldShowSpinner)
    {
        _shouldShowSpinner = shouldShowSpinner;
        _shouldShowSpinner ? [self showSpinner] : [self hideSpinner];
    }
}

- (void)showSpinner
{
    [self.userReposListSpinner startAnimating];
    self.userReposListSpinner.hidden = NO;
}

- (void)hideSpinner
{
    self.userReposListSpinner.hidden = YES;
    [self.userReposListSpinner stopAnimating];
}

- (void)setUserRepos:(NSArray *)userRepos
{
    if (_userRepos != userRepos)
    {
        _userRepos = userRepos;
        NSLog(@"reload table");
        [self.repositoriesListTable reloadData];
    }
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.userRepos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHSRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSRepositoryCellID"];
    
    GHSRepository *repository = self.userRepos[indexPath.row];
    cell.repoNameLabel.text = repository.name;
    cell.stargazersCountLabel.text = [NSString localizedStringWithFormat:@"%lu", (unsigned long)repository.stargazersCount];
    cell.forksCountLabel.text = [NSString localizedStringWithFormat:@"%lu", (unsigned long)repository.forksCount];
    cell.openIssuesCountLabel.text = [NSString localizedStringWithFormat:@"%lu", (unsigned long)repository.openIssuesCount];
    
    return cell;
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.repoSelectedCommand execute:self.userRepos[indexPath.row]];
}

@end
