//
//  CAAnimation+TuneKit.m
//  TuneKit
//
//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "CAAnimation+TuneKit.h"
#import "TuneKit.h"

@implementation CAAnimation (TuneKit)

+ (TKSegmentedControlConfig *)addMediaTimingFunctionNameConfig:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    if ([TuneKit isEnabled]) {
        NSArray *names = @[@"Default", @"Linear", @"In", @"Out", @"InOut"];
        NSArray *values = @[
                            kCAMediaTimingFunctionDefault,
                            kCAMediaTimingFunctionLinear,
                            kCAMediaTimingFunctionEaseIn,
                            kCAMediaTimingFunctionEaseOut,
                            kCAMediaTimingFunctionEaseInEaseOut];
        return [TuneKit addSegmentedControl:name target:target keyPath:keyPath segmentNames:names segmentValues:values];
    }
    return nil;
}

@end
