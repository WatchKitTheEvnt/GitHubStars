//
//  GHSUserPullRequest.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSUserPullRequest.h"
#import "GHSPullRequest.h"

static NSString *const GHSUserPullRequestListKey = @"pullRequests";

@interface GHSUserPullRequest ()

@property (nonatomic) GHSPullRequest *latestPullRequest;

@end

@implementation GHSUserPullRequest

- (instancetype)initWithPullRequest:(NSArray *)pullRequest
{
    self = [super init];
    if (self)
    {
        NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"updatedDate" ascending:YES];
        NSArray *sortDescriptor = [NSArray arrayWithObject:dateDescriptor];
        _pullRequest = [pullRequest sortedArrayUsingDescriptors:sortDescriptor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self)
    {
        _pullRequest  = [coder decodeObjectForKey:GHSUserPullRequestListKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.pullRequest forKey:GHSUserPullRequestListKey];
}

- (GHSPullRequest *)latestPullRequest
{
    return [_pullRequest lastObject];
}

- (GHSPullRequest *)pullRequestByTitle:(NSString *)title
{
    GHSPullRequest *localPullRequest = nil;
    for (GHSPullRequest *pullRequest in self.pullRequest)
    {
        if ([pullRequest.title isEqualToString:title])
        {
            localPullRequest = pullRequest;
            break;
        }
    }
    return localPullRequest;
}


@end
