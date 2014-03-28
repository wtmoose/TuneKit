//
//  TKUIViewAnimation.m
//  TuneKit
//
//  Created by Tim Moose on 3/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKUIViewAnimation.h"

NSString *TKPluginName(NSString *prefix, NSString *suffix) {
    NSMutableArray *components = [NSMutableArray arrayWithCapacity:2];
    if (prefix) {
        [components addObject:prefix];
    }if (suffix) {
        [components addObject:suffix];
    }
    return [components componentsJoinedByString:@" "];
}

@interface TKUIViewAnimation ()
@property (strong, nonatomic) NSString *name;
@end

@implementation TKUIViewAnimation

- (void)setEasingCurve:(UIViewAnimationOptions)easingCurve
{
    _easingCurve = easingCurve;
    [self mergeEasingCurveIntoOptions];
}

- (void)setOptions:(UIViewAnimationOptions)options
{
    _options = options;
    [self mergeEasingCurveIntoOptions];
}

- (void)mergeEasingCurveIntoOptions
{
    _options = _options & ~UIViewAnimationOptionCurveLinear & ~UIViewAnimationOptionCurveEaseIn & ~UIViewAnimationOptionCurveEaseOut & ~UIViewAnimationOptionCurveEaseInOut;
    _options = _options | self.easingCurve;
}

#pragma mark - Running the animation

- (void)performAnimation
{
    [UIView animateWithDuration:self.duration
                          delay:self.delay
                        options:self.options
                     animations:self.animations
                     completion:self.completion];
}

#pragma mark - Creating plugins

+ (instancetype)animimation
{
    return [self animimationWithName:nil];
}

+ (instancetype)animimationWithName:(NSString *)name
{
    TKUIViewAnimation *animation = [[TKUIViewAnimation alloc] init];
    animation.name = name;
    return animation;
}

#pragma mark - TKPlugin

- (void)addControls
{
    [TuneKit addSlider:TKPluginName(self.name, @"Duration") target:self keyPath:@"duration" min:0.f max:2.f * self.duration];
    [TuneKit addSlider:TKPluginName(self.name, @"Delay") target:self keyPath:@"delay" min:0.f max:2.f * self.delay];
    [TuneKit addSegmentedControl:TKPluginName(self.name, @"Easing")
                          target:self
                         keyPath:@"easingCurve"
                    segmentNames:@[@"Linear", @"In", @"Out", @"In/Out"]
                   segmentValues:@[@(UIViewAnimationOptionCurveLinear), @(UIViewAnimationOptionCurveEaseIn), @(UIViewAnimationOptionCurveEaseOut), @(UIViewAnimationOptionCurveEaseInOut)]];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TKUIViewAnimation *copy = [[TKUIViewAnimation alloc] init];
    copy.duration = self.duration;
    copy.delay = self.delay;
    copy.easingCurve = self.easingCurve;
    copy.options = self.options;
    copy.animations = [self.animations copy];
    copy.completion = [self.completion copy];
    return copy;
}

@end
