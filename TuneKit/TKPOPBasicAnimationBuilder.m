//  Created by Tim Moose on 5/13/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPBasicAnimationBuilder.h"
#import "CAAnimation+TuneKit.h"

@implementation TKPOPBasicAnimationBuilder

#pragma mark - Creating the animation

- (POPBasicAnimation *)animation
{
    return [self animationWithPropertyNamed:nil];
}

- (POPBasicAnimation *)animationWithPropertyNamed:(NSString *)name
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:name];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:6];
        [controls addObjectsFromArray:[super addAllControls]];
        [controls addObject:[self addDurationControl]];
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
    return [[TKPOPBasicAnimationBuilder alloc] init];
}

@end
