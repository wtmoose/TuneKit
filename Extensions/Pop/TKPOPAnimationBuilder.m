//  Created by Tim Moose on 5/12/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPAnimationBuilder.h"

@implementation TKPOPAnimationBuilder

#pragma mark - Creating the animation

- (CAAnimation *)animation
{
    return nil; // TODO raise exception?
}

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:3];
        [controls addObject:[self addDelayControl]];
        return controls;
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

#pragma mark - Creating builders

+ (instancetype)builder
{
    return nil;// TODO raise exception?
}

@end
