//
//  GHSRepositoryRowController.h
//  GitHubStars
//
//  Created by Víctor on 17/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface GHSRepositoryRowController : NSObject

- (void)setRepositoryName:(NSString *)repositoryName;

- (void)setStargazeCount:(NSUInteger)startgazeCount;

- (void)setForksCount:(NSUInteger)forksCount;

- (void)setOpenIssuesCount:(NSUInteger)openIssuesCount;

@end
