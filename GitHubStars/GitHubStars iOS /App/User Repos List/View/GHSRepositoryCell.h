//
//  GHSRepositoryCell.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 27/02/15.
//  Copyright (c) 2015 Tuenti Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHSRepositoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *repoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stargazersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *forksCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *openIssuesCountLabel;

@end
