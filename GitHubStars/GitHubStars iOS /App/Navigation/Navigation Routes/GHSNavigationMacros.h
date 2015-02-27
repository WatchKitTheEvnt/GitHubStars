//
//  GHSNavigationMacros.h
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#ifndef GitHubStars_GHSNavigationMacros_h
#define GitHubStars_GHSNavigationMacros_h

#define enforceContextIsInstanceOf(context, clazz) \
do { \
NSAssert([context isKindOfClass:clazz], @"Invalid context for creating ViewModel! Expected instance of %@, was instance of %@", NSStringFromClass(clazz), NSStringFromClass([context class])); \
} while (0)

#define enforceControllerIsInstanceOf(controller, clazz) \
do { \
NSAssert([controller isKindOfClass:clazz], @"Invalid ViewController! Expected instance of %@, was instance of %@", NSStringFromClass(clazz), NSStringFromClass([controller class])); \
} while (0)

#endif
