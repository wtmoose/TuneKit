//
//  TKAHEasingAnimationBuilder.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 tractablelabs.com. All rights reserved.
//

#import "TKAHEasingAnimationBuilder.h"
#import "CAKeyframeAnimation+TKAHEasing.h"
#import <AHEasing/CAKeyframeAnimation+AHEasing.h>

@implementation TKAHEasingAnimationBuilder

#pragma mark - Creating the animation

- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    AHEasingFunction easingFunction = [CAKeyframeAnimation easingFunctionForName:self.easingFunctionName];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath function:easingFunction fromValue:fromValue toValue:toValue keyframeCount:self.numberOfKeyframes];
    [self configureAnimation:animation];
    return animation;
}

- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
{
    AHEasingFunction easingFunction = [CAKeyframeAnimation easingFunctionForName:self.easingFunctionName];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath function:easingFunction fromPoint:fromPoint toPoint:toPoint keyframeCount:self.numberOfKeyframes];
    [self configureAnimation:animation];
    return animation;
}

- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath fromSize:(CGSize)fromSize toSize:(CGSize)toSize
{
    AHEasingFunction easingFunction = [CAKeyframeAnimation easingFunctionForName:self.easingFunctionName];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath function:easingFunction fromSize:fromSize toSize:toSize keyframeCount:self.numberOfKeyframes];
    [self configureAnimation:animation];
    return animation;
}

- (void)configureAnimation:(CAKeyframeAnimation *)animation
{
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
}

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls
{
    NSMutableArray *controls = [NSMutableArray arrayWithCapacity:4];
    [controls addObject:[self addDurationControl]];
    [controls addObject:[self addDelayControl]];
    [controls addObject:[self addEasingFunctionNameControl]];
    [controls addObject:[self addNumberOfKeyframesControl]];
    return controls;
}

- (TKPickerViewConfig *)addEasingFunctionNameControl
{
    return [CAKeyframeAnimation addAHEasingFunctionNameConfig:@"Easing" target:self keyPath:@"easingFunctionName"];
}

- (TKSliderConfig *)addNumberOfKeyframesControl
{
    return [TuneKit addSlider:@"# Keyframes" target:self keyPath:@"numberOfKeyframes" min:5 max:120];
}

#pragma mark - Creating animators

+ (instancetype)animator
{
    return [[TKAHEasingAnimationBuilder alloc] init];
}

- (id)init
{
    if (self = [super init]) {
        _numberOfKeyframes = 60;
        _easingFunctionName = @"Linear Interpolation";
    }
    return self;
}

@end
