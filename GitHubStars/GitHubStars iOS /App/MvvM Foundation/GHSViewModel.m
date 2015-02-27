//
//  GHSViewModel.m
//  GitHubStars
//
//  Created by César Estébanez Tascón on 09/01/15.
//  Copyright (c) 2015 Cesar Estebanez Tascon. All rights reserved.
//

#import "GHSViewModel.h"

@implementation GHSViewModel

- (void)willActivate
{
    self.status = DoingStuff;
}

- (void)willDeactivate
{
    self.status = DoneWithContext(nil);
}

@end
