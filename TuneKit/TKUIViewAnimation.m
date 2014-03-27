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
@property (nonatomic) NSTimeInterval minDuration;
@property (nonatomic) NSTimeInterval maxDuration;
@property (nonatomic) NSTimeInterval minDelay;
@property (nonatomic) NSTimeInterval maxDelay;
@end

@implementation TKUIViewAnimation

- (void)setDuration:(NSTimeInterval)duration
{
    NSTimeInterval min = MIN(duration, self.minDuration);
    NSTimeInterval max = MAX(duration, self.maxDuration);
    [self setDuration:duration min:min max:max];
}

- (void)setDuration:(NSTimeInterval)duration min:(NSTimeInterval)min max:(NSTimeInterval)max
{
    _duration = duration;
    self.minDuration = min;
    self.maxDuration = max;
}

- (void)setDelay:(NSTimeInterval)delay
{
    NSTimeInterval min = MIN(delay, self.minDelay);
    NSTimeInterval max = MAX(delay, self.maxDelay);
    [self setDuration:delay min:min max:max];
}

- (void)setDelay:(NSTimeInterval)delay min:(NSTimeInterval)min max:(NSTimeInterval)max
{
    _delay = delay;
    self.minDelay = min;
    self.maxDelay = max;
}

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
    // TODO
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

+ (instancetype)viewAnimimation
{
    return [self viewAnimimationWithName:nil];
}

+ (instancetype)viewAnimimationWithName:(NSString *)name
{
    TKUIViewAnimation *animation = [[TKUIViewAnimation alloc] init];
    animation.name = name;
    return animation;
}

#pragma mark - TKPlugin

- (void)addControls
{
    [TuneKit addSlider:TKPluginName(self.name, @"Duration") target:self keyPath:@"duration" min:self.minDuration max:self.maxDuration];
    [TuneKit addSlider:TKPluginName(self.name, @"Delay") target:self keyPath:@"delay" min:self.minDelay max:self.maxDelay];
}

@end
