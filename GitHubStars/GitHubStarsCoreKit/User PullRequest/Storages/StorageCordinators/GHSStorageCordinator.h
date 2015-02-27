//
//  GHSStorageCordinatorProtocol.h
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSSerializableModel.h"


@protocol GHSStorageCordinator <NSObject>

- (void)saveSerializableModel:(GHSSerializableModel *)model forKey:(NSString *)key withCompletionHandler:(void (^)(NSError *error))completionHandler;

- (void)loadSerializableModelForKey:(NSString *)key withCompletionHandler:(void (^)(GHSSerializableModel *model, NSError *error))completionHandler;

- (void)clearSerializableModelForKey:(NSString *)key withCompletionHandler:(void (^)(NSError *error))completionHandler;

@end
