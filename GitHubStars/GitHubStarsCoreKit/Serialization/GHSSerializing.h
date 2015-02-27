//
//  GHSSerializing.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 21/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GHSSerializing <NSObject>

+ (instancetype)deserialize:(NSData *)serializedData;

- (NSData *)serialize;

@end
