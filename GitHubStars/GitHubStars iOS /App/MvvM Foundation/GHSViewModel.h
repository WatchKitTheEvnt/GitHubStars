//
//  GHSViewModel.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHSViewModelStatus.h"

/**
 Base class for VieModels. Provides declarations and default implementations of the lifeCycle methods. Also sets the status to the default 
 value (DoingStuff).
 */
@interface GHSViewModel : NSObject

/*
 In order to being able to navigate between different screens, ViewModels must have a status property. GHSNavigator observes this property
 to know when the navigation should start. Property currentStatus must be set to GHSViewModelDone to trigger a navigation transition.
 */
@property (nonatomic) GHSViewModelStatus *status;

/*
 All ViewModels receive a call to willActivate when the associated ViewController is about to appear in the screen (viewVillAppear).
 The default implementation sets the status to DoingStuff. Subclasses that overrides this method must call super or manually manage 
 the status.
 */
- (void)willActivate;

/*
 All ViewModels receive a call to willDeactivate when the associated ViewController is about to dissapear from the screen (viewWillDisappear).
 The default implementation sets the status to DoneWithContext(nil). Subclasses that overrides this method must call super or manually manage
 the status.
 */
- (void)willDeactivate;

@end
