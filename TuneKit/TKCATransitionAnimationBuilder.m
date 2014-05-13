//
//  CATransitionAnimator.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKCATransitionAnimationBuilder.h"

@implementation TKCATransitionAnimationBuilder

#pragma mark - Creating the animation

- (CATransition *)animation
{
    CATransition *animation = [CATransition animation];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Creating builders

+ (instancetype)builder
{
    return [[TKCATransitionAnimationBuilder alloc] init];
}

@end