//
//  GHSViewModelStatus.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 12/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSViewModelStatus.h"

@implementation GHSViewModelStatus

+ (instancetype)doingStuff
{
    return [[self alloc] initWithCurrentStatus:GHSViewModelDoingStuff context:nil];
}

+ (instancetype)doneWithContext:(id)context
{
    return [[self alloc] initWithCurrentStatus:GHSViewModelDone context:context];
}

- (instancetype)initWithCurrentStatus:(GHSViewModelStatusType)currentStatus context:(id)context
{
    self = [super init];
    if (self)
    {
        _currentStatus = currentStatus;
        _context = context;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (object == self)
    {
        return YES;
    }
    if (!object || ![object isKindOfClass:[self class]])
    {
        return NO;
    }
    return [self isEqualToStatus:object];
}

- (BOOL)isEqualToStatus:(GHSViewModelStatus *)status
{
    // We consider two status to be equal if their currentStatus is equal, no matter the context
    return self.currentStatus == status.currentStatus;
}

- (NSUInteger)hash
{
    // Worst hash function ever, but it is the only one consistent with our isEqual: implementation.
    // Anyway, we are not using the hash, so no problem.
    return self.currentStatus;
}

@end
