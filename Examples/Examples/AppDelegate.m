//
//  AppDelegate.m
//  Examples
//
//  Created by Tim Moose on 2/11/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "AppDelegate.h"
#import <TuneKit/TuneKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // enable TuneKit
    [TuneKit enable];

    return YES;
}

@end
