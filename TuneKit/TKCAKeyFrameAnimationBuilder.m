//
//  TKCAKeyFrameAnimationBuilder.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKCAKeyFrameAnimationBuilder.h"

@implementation TKCAKeyFrameAnimationBuilder

#pragma mark - Creating the animation

- (CAKeyframeAnimation *)animation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Creating builders

+ (instancetype)builder
{
    return [[TKCAKeyFrameAnimationBuilder alloc] init];
}

@end
