//
//  GHSSharedKeys.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 17/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSSharedKeys.h"

NSString *const GHSWatchKitExtensionRequestType = @"GHSWatchKitExtensionRequest";
NSString *const GHSWatchKitExtensionRequestTypeFetchUserRespoitories = @"GHSRequestFetchUserRespoitories";
NSString *const GHSContainingAppReplyFetchedUserRespoitories = @"GHSWatchKitExtensionReplyFetchedUserRespoitories";
NSString *const GHSWatchKitExtensionRequestTypeFetchUserPullRequest = @"GHSRequestFetchUserPullRequest";
NSString *const GHSContainingAppReplyFetchedUserPullRequest = @"GHSWatchKitExtensionReplyFetchedUserPullRequest";
NSString *const GHSContainingAppReplyError = @"GHSContainingAppReplyError";
NSString *const GHSContainingAppReplyErrorDomain = @"GHSContainingAppReplyErrorDomain";
NSUInteger const GHSContainingAppReplyErrorUnknownRequestType = 0;
NSUInteger const GHSContainingAppReplyErrorUnableToFetchInTime = 1;
NSUInteger const GHSContainingAppReplyErrorNotAuthenticatedCode = 2;

NSString *const GHSNewStarLocalNotificationKey = @"GHSNewStarLocalNotificationKey";
NSString *const GHSNewStarLocalNotificationCategoryKey = @"GHSNewStarLocalNotificationCategoryKey";

NSString *const GHSWatchKitExtensionRequestValues = @"GHSWatchKitExtensionRequestValues";

// Values for RequestType FetchPullrequest
NSString *const GHSWatchKitExtensionRequestValuePullRequestRepositoryName = @"GHSWatchKitExtensionRequestValuePullRequestRepositoryName";
NSString *const GHSWatchKitExtensionRequestValuePullRequestRepositoryOwner = @"GHSWatchKitExtensionRequestValuePullRequestRepositoryOwner";






