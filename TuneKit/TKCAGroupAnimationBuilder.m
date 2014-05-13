//
//  TKCAGroupAnimationBuilder.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKCAGroupAnimationBuilder.h"

@implementation TKCAGroupAnimationBuilder

#pragma mark - Creating the animation

- (CAAnimationGroup *)animation
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Creating builders

+ (instancetype)builder
{
    return [[TKCAGroupAnimationBuilder alloc] init];
}

@end
