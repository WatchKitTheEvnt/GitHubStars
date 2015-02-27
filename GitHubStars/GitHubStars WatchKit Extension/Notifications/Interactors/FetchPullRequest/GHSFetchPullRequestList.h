//
//  GHSFetchPullRequestList.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 23/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHSUserPullRequest;
@interface GHSFetchPullRequestList : NSObject

- (void)fecthUserPullRequestForRepositoryName:(NSString *)repositoryName
                              repositoryOwner:(NSString *)repositoryOwner
                               withCompletion:(void (^)(GHSUserPullRequest *pullRequest))completionHandler;

@end
