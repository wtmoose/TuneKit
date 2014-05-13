//
//  TKCABasicAnimationBuilder.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKCABasicAnimationBuilder.h"

@implementation TKCABasicAnimationBuilder

#pragma mark - Creating the animation

- (CABasicAnimation *)animation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Creating builders

+ (instancetype)builder
{
    return [[TKCABasicAnimationBuilder alloc] init];
}

@end
