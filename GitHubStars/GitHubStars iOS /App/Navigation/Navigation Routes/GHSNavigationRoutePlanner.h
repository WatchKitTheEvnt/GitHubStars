//
//  GHSNavigationRoutePlanner.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 13/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GHSViewModel;
@protocol GHSNavigationRoute;

@interface GHSNavigationRoutePlanner : NSObject

@property (nonatomic) UIStoryboard *storyboard;

- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard;

- (id<GHSNavigationRoute>)routeFromViewModel:(GHSViewModel *)viewModel context:(id)context;

@end
