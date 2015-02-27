//
//  main.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 25/2/15.
//  Copyright (c) 2015 Tuenti Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TestAppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        BOOL runningTests = NSClassFromString(@"XCTestCase") != nil;
        if(!runningTests)
        {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        else
        {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([TestAppDelegate class]));
        }
    }
}
