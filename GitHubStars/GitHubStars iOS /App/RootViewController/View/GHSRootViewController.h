//
//  GHSRootViewController.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 08/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GHSRootViewModel;

@interface GHSRootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic) GHSRootViewModel *viewModel;

@end
