//  Created by Tim Moose on 3/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKUIViewAnimator.h"
#import "TuneKit.h"

@interface TKUIViewAnimator ()
@end

@implementation TKUIViewAnimator

#pragma mark - Configuring the animator

- (void)setEasing:(UIViewAnimationOptions)easing
{
    _easing = easing;
    _options = [UIView mergeEasing:_easing andOtherOptions:_options];
}

- (void)setOptions:(UIViewAnimationOptions)options
{
    _options = options;
    _options = [UIView mergeEasing:_easing andOtherOptions:_options];
}

#pragma mark - Running the animation

- (void)animateWithAnimations:(void (^)(void))animations
{
    [self animateWithAnimations:animations withCompletion:nil];
}

- (void)animateWithAnimations:(void (^)(void))animations
               withCompletion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:self.duration
                          delay:self.delay
                        options:self.options
                     animations:animations
                     completion:completion];
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:3];
        [controls addObject:[self addDurationControl]];
        [controls addObject:[self addDelayControl]];
        [controls addObject:[self addEasingControl]];
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

- (TKSegmentedControlConfig *)addEasingControl
{
    if ([TuneKit isEnabled]) {
        return [UIView addAnimationEasingCurveConfig:@"Easing"
                                              target:self
                                             keyPath:@"easing"];
    }
    return nil;
}

#pragma mark - Creating animators

+ (instancetype)animator
{
    return [[TKUIViewAnimator alloc] init];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TKUIViewAnimator *copy = [[[self class] alloc] init];
    copy.duration = self.duration;
    copy.delay = self.delay;
    copy.easing = self.easing;
    copy.options = self.options;
    return copy;
}

@end
