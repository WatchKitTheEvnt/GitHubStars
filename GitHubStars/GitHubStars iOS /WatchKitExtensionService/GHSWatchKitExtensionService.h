//
//  GHSWatchKitExtensionService.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 16/02/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GHSWatchKitExtensionServiceModule;

@interface GHSWatchKitExtensionService : NSObject

@property (nonatomic) GHSWatchKitExtensionServiceModule *watchKitExtensionServiceModule;

- (instancetype)initWithWatchKitExtensionServiceModule:(GHSWatchKitExtensionServiceModule *)watchKitExtensionServiceModule;

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply;

@end
