//
//  UIView+TuneKit.m
//  TuneKit
//
//  Created by Tim Moose on 4/1/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "UIView+TuneKit.h"

@implementation UIView (TuneKit)

+ (TKSegmentedControlConfig *)addAnimationEasingCurveConfig:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    if ([TuneKit isEnabled]) {
        NSArray *names = @[@"Linear", @"In", @"Out", @"In/Out"];
        NSArray *values = @[@(UIViewAnimationOptionCurveLinear), @(UIViewAnimationOptionCurveEaseIn), @(UIViewAnimationOptionCurveEaseOut), @(UIViewAnimationOptionCurveEaseInOut)];
        return [TuneKit addSegmentedControl:name target:target keyPath:keyPath segmentNames:names segmentValues:values];
    }
    return nil;
}

@end
