//
//  CAGroupAnimator.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "CAGroupAnimator.h"

@implementation CAGroupAnimator

#pragma mark - Creating the animation

- (CAAnimationGroup *)animation
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.duration = self.duration;
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.mediaTimingFunctionName];
    return animation;
}

#pragma mark - Creating animators

+ (instancetype)animimator
{
    return [self animimatorWithNamePrefix:nil];
}

+ (instancetype)animimatorWithNamePrefix:(NSString *)namePrefix
{
    return [[CAGroupAnimator alloc] initWithNamePrefix:namePrefix];
}

@end