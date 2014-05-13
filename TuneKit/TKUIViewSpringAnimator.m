//
//  TKUIViewSpringAnimator.m
//  TuneKit
//
//  Created by Tim Moose on 4/4/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKUIViewSpringAnimator.h"
#import "TuneKit.h"

@implementation TKUIViewSpringAnimator

#pragma mark - Performing the animation

- (void)animateWithAnimations:(void (^)(void))animations withCompletion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:self.duration
                          delay:self.delay
         usingSpringWithDamping:self.damping
          initialSpringVelocity:self.initialVelocity
                        options:self.options
                     animations:animations
                     completion:completion];
}

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls
{
    NSMutableArray *controls = [[super addAllControls] mutableCopy];
    [controls addObject:[self addDampingControl]];
    [controls addObject:[self addInitialVelocityControl]];
    return controls;
}

- (TKSliderConfig *)addDampingControl
{
    return [TuneKit addSlider:@"Damping"
                       target:self
                      keyPath:@"damping"
                          min:0.f
                          max:1.f];
}

- (TKSliderConfig *)addInitialVelocityControl
{
    CGFloat max = MAX(50.f, 2.f*fabs(self.initialVelocity));
    return [TuneKit addSlider:@"Initial Velocity"
                       target:self
                      keyPath:@"initialVelocity"
                          min:-max
                          max:max];
}

#pragma mark - Creating animator

+ (instancetype)animator
{
    return [[TKUIViewSpringAnimator alloc] init];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    TKUIViewSpringAnimator *copy = [super copyWithZone:zone];
    copy.damping = self.damping;
    copy.initialVelocity = self.initialVelocity;
    return copy;
}

@end
