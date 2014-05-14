//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKCAAnimationBuilder.h"
#import "TuneKit.h"
#import "CAAnimation+TuneKit.h"

@implementation TKCAAnimationBuilder

#pragma mark - Creating the animation

- (CAAnimation *)animation
{
    return nil; // TODO raise exception?
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:3];
        [controls addObject:[self addDurationControl]];
        [controls addObject:[self addDelayControl]];
        [controls addObject:[self addMediaTimingFunctionNameControl]];
        return controls;
    }
    return nil;
}

- (TKSliderConfig *)addDurationControl
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.duration);
        return [TuneKit addSlider:@"Duration"
                           target:self
                          keyPath:@"duration"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addDelayControl
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.delay);
        return [TuneKit addSlider:@"Delay"
                           target:self
                          keyPath:@"delay"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSegmentedControlConfig *)addMediaTimingFunctionNameControl
{
    if ([TuneKit isEnabled]) {
        return [CAAnimation addMediaTimingFunctionNameConfig:@"Easing"
                                                  target:self
                                                 keyPath:@"mediaTimingFunctionName"];
    }
    return nil;
}

#pragma mark - Creating builders

+ (instancetype)builder
{
    return nil;// TODO raise exception?
}

@end
