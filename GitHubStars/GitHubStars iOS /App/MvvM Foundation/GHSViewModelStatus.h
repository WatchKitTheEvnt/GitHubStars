//
//  GHSViewModelStatus.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 12/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GHSViewModelStatusType) {
    GHSViewModelDoingStuff,
    GHSViewModelDone,
};

#define DoingStuff [GHSViewModelStatus doingStuff];
#define DoneWithContext(context) [GHSViewModelStatus doneWithContext:context];

/**
 Describes the status of a ViewModel. Possible status are DoingStuff & Done.
 
 ViewModel status is used to orchestrate navigation. The Navigator observes the status property of the ViewModel
 currently on screen. When a ViewModel is Done, the Navigator reacts navigating to a different screen. ViewModels
 may provide a context for the next screen.
 
 Example: The responsibility of the AuthenticationViewModel is to sign in against GitHub API. Once authenticated,
 the ViewModel sets its status to Done, and provides an authenticated instance of OCTClient as context for the 
 next screen.
 */
@interface GHSViewModelStatus : NSObject

@property (nonatomic) GHSViewModelStatusType currentStatus;
@property (nonatomic) id context;

// Convenience factory methods
+ (instancetype)doingStuff;
+ (instancetype)doneWithContext:(id)context;

- (instancetype)initWithCurrentStatus:(GHSViewModelStatusType)currentStatus context:(id)context;

@end
