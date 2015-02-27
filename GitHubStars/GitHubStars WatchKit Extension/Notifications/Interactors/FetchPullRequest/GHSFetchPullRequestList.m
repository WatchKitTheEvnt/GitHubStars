//
//  GHSFetchPullRequestList.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSFetchPullRequestList.h"
#import <GitHubStarsCoreKit/GitHubStarsCoreKit.h>
#import <WatchKit/WatchKit.h>
#import "GHSSharedKeys.h"

@implementation GHSFetchPullRequestList

- (void)fecthUserPullRequestForRepositoryName:(NSString *)repositoryName
                              repositoryOwner:(NSString *)repositoryOwner
                               withCompletion:(void (^)(GHSUserPullRequest *pullRequest))completionHandler
{
    // Create requestValues for fetchPullRequest
    NSDictionary *requestValues = @{GHSWatchKitExtensionRequestValuePullRequestRepositoryName : repositoryName,
                                    GHSWatchKitExtensionRequestValuePullRequestRepositoryOwner : repositoryOwner};
    
    // Ask iOS App to fetch pullRequest for us
    NSDictionary *userInfo = @{GHSWatchKitExtensionRequestType : GHSWatchKitExtensionRequestTypeFetchUserPullRequest,
                               GHSWatchKitExtensionRequestValues : requestValues };
    [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"Received Response from containing iOS App");
        if (!error)
        {
            NSData *fetchedUserPullRequestListData = replyInfo[GHSContainingAppReplyFetchedUserPullRequest];
            GHSUserPullRequest *fetchedUserPullRequest = [GHSUserPullRequest deserialize:fetchedUserPullRequestListData];
            NSAssert([fetchedUserPullRequest isKindOfClass:[GHSUserPullRequest class]], @"Error deserializing user pull request");
            if (fetchedUserPullRequest && completionHandler)
            {
                completionHandler(fetchedUserPullRequest);
            }
        }
    }];

}

@end
