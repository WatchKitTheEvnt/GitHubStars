//
//  GHSPullRequest.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSSerializableModel.h"


typedef NS_ENUM(NSInteger, GHSPullRequestState)
{
    GHSPullRequestStateOpen,
    GHSPullRequestStateClosed
};

@class GHSRepository;
@interface GHSPullRequest : GHSSerializableModel

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, readonly) GHSPullRequestState state;
@property (nonatomic, copy, readonly) NSURL *diffURL;
@property (nonatomic, readonly) GHSRepository *baseRepository; // The repository that the pull request's changes should be pulled into.
@property (nonatomic, readonly) NSDate *updatedDate; // The date/time this pull request was last updated.

- (instancetype)initWithTitle:(NSString *)title
                         body:(NSString *)body
                     userName:(NSString *)userName
                        state:(GHSPullRequestState)state
                      diffURL:(NSURL *)diffURL
               baseRepository:(GHSRepository *)baseRepository
                  updatedDate:(NSDate *)updatedDate;

@end
