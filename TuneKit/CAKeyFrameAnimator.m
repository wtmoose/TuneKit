//
//  CAKeyFrameAnimator.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "CAKeyFrameAnimator.h"

@implementation CAKeyFrameAnimator

#pragma mark - Creating the animation

- (CAKeyframeAnimation *)animation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Creating animators

+ (instancetype)animator
{
    return [[CAKeyFrameAnimator alloc] init];
}

@end
