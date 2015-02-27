//
//  GHSSerializableModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 21/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSSerializableModel.h"

/** Define enclosing method as ABSTRACT, meaning if not implementation is provided in subclasses, an exception will be raised */
#define GHSAbstractMethod { \
    [NSException raise:NSInvalidArgumentException format:@"[%@ %@] should be overridden by subclass", \
                                                  NSStringFromClass([self class]), \
                                                  _cmd ? NSStringFromSelector(_cmd) : @"(null)"]; \
    __builtin_unreachable(); \
}

@implementation GHSSerializableModel

+ (instancetype)deserialize:(NSData *)serializedData
{
    if (serializedData)
    {
        return [NSKeyedUnarchiver unarchiveObjectWithData:serializedData];
    }
    return nil;
}

- (NSData *)serialize
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    GHSAbstractMethod;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    GHSAbstractMethod;
}

@end
