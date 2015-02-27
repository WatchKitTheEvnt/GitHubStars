//
//  GHSSharedKeys.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 17/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

// WatchKit Extension Requests
FOUNDATION_EXPORT NSString *const GHSWatchKitExtensionRequestType;
FOUNDATION_EXPORT NSString *const GHSWatchKitExtensionRequestTypeFetchUserRespoitories;
FOUNDATION_EXPORT NSString *const GHSWatchKitExtensionRequestTypeFetchUserPullRequest;
FOUNDATION_EXPORT NSString *const GHSWatchKitExtensionRequestValues;

// WatchKit Extension Values for RequestType FetchPullrequest
FOUNDATION_EXPORT NSString *const GHSWatchKitExtensionRequestValuePullRequestRepositoryName;
FOUNDATION_EXPORT NSString *const GHSWatchKitExtensionRequestValuePullRequestRepositoryOwner;

// WatchKit Extension Replies
FOUNDATION_EXPORT NSString *const GHSContainingAppReplyFetchedUserRespoitories;
FOUNDATION_EXPORT NSString *const GHSContainingAppReplyFetchedUserPullRequest;
FOUNDATION_EXPORT NSString *const GHSContainingAppReplyError;
FOUNDATION_EXPORT NSString *const GHSContainingAppReplyErrorDomain;
FOUNDATION_EXPORT NSUInteger const GHSContainingAppReplyErrorUnknownRequestType;
FOUNDATION_EXPORT NSUInteger const GHSContainingAppReplyErrorUnableToFetchInTime;
FOUNDATION_EXPORT NSUInteger const GHSContainingAppReplyErrorNotAuthenticatedCode;

// Notifications Keys
FOUNDATION_EXPORT NSString *const GHSNewStarLocalNotificationKey;
FOUNDATION_EXPORT NSString *const GHSNewStarLocalNotificationCategoryKey;

