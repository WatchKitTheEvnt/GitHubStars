//
//  GHSPullRequest.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSPullRequest.h"

static NSString *const GHSPullRequestTitleKey = @"tile";
static NSString *const GHSPullRequestBodyKey = @"body";
static NSString *const GHSPullRequestUserNameKey = @"userName";
static NSString *const GHSPullRequestStateNameKey = @"state";
static NSString *const GHSPullRequestDiffNameKey = @"diffURL";
static NSString *const GHSPullRequestBaseRespositoryKey = @"baseRepository";
static NSString *const GHSPullRequestUpdateDateKey = @"updateDate";

@implementation GHSPullRequest

- (instancetype)initWithTitle:(NSString *)title
                         body:(NSString *)body
                     userName:(NSString *)userName
                        state:(GHSPullRequestState)state
                      diffURL:(NSURL *)diffURL
               baseRepository:(GHSRepository *)baseRepository
                  updatedDate:(NSDate *)updatedDate
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _body = [body copy];
        _userName = [userName copy];
        _state = state;
        _diffURL = diffURL;
        _baseRepository = baseRepository;
        _updatedDate = updatedDate;
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self)
    {
        _title = [coder decodeObjectForKey:GHSPullRequestTitleKey];
        _body = [coder decodeObjectForKey:GHSPullRequestBodyKey];
        _userName = [coder decodeObjectForKey:GHSPullRequestUserNameKey];
        _state = [[coder decodeObjectForKey:GHSPullRequestStateNameKey] unsignedIntegerValue];
        _diffURL = [coder decodeObjectForKey:GHSPullRequestDiffNameKey];
        _baseRepository = [coder decodeObjectForKey:GHSPullRequestBaseRespositoryKey];
        _updatedDate = [coder decodeObjectForKey:GHSPullRequestUpdateDateKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:GHSPullRequestTitleKey];
    [coder encodeObject:self.body forKey:GHSPullRequestBodyKey];
    [coder encodeObject:self.userName forKey:GHSPullRequestUserNameKey];
    [coder encodeObject:@(self.state) forKey:GHSPullRequestStateNameKey];
    [coder encodeObject:self.diffURL forKey:GHSPullRequestDiffNameKey];
    [coder encodeObject:self.baseRepository forKey:GHSPullRequestBaseRespositoryKey];
    [coder encodeObject:self.updatedDate forKey:GHSPullRequestUpdateDateKey];
}

@end
