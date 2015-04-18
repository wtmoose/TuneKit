//
//  TKRBBSpringAnimationBuilder.m
//  TuneKit
//
//  Created by Tim Moose on 4/18/15.
//  Copyright (c) 2015 Tractable Labs. All rights reserved.
//

#import "TKRBBSpringAnimationBuilder.h"
#import <QuartzCore/QuartzCore.h>

@interface TKRBBSpringAnimationBuilder ()
@property (strong, nonatomic) RBBSpringAnimation *prototype;
@property (nonatomic) BOOL durationLabelAdded;
@end

@implementation TKRBBSpringAnimationBuilder

#pragma mark - Configuring the builder

- (CGFloat)damping
{
    return self.prototype.damping;
}

- (void)setDamping:(CGFloat)damping
{
    self.prototype.damping = damping;
    [self updateDuration];
}

- (CGFloat)mass
{
    return self.prototype.mass;
}

- (void)setMass:(CGFloat)mass
{
    self.prototype.mass = mass;
    [self updateDuration];
}

- (CGFloat)stiffness
{
    return self.prototype.stiffness;
}

- (void)setStiffness:(CGFloat)stiffness
{
    self.prototype.stiffness = stiffness;
    [self updateDuration];
}

- (void)setDurationAdjustment:(CGFloat)durationAdjustment
{
    _durationAdjustment = durationAdjustment;
    [self updateDuration];
}

- (void)updateDuration {
    if (self.durationLabelAdded) {
        self.prototype.duration = [self.prototype durationForEpsilon:0.01] + self.durationAdjustment;
    }
}

#pragma mark - Creating the animation

- (RBBSpringAnimation *)animation
{
    return [self.prototype copy];
//    RBBSpringAnimation *animation = [RBBSpringAnimation animation];
//    animation.damping = self.damping;
//    animation.mass = self.mass;
//    animation.stiffness = self.stiffness;
//    return animation;
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:4];
        [controls addObject:[self addDampingControl]];
        [controls addObject:[self addMassControl]];
        [controls addObject:[self addStiffnessControl]];
        [controls addObject:[self addDurationAdjustment]];
        [controls addObject:[self addDurationLabel]];
        return controls;
    }
    return nil;
}

- (TKSliderConfig *)addDampingControl
{
    if ([TuneKit isEnabled]) {
        CGFloat max = MAX(10.0f, 4.f * self.damping);
        return [TuneKit addSlider:@"Damping"
                           target:self
                          keyPath:@"damping"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addMassControl
{
    if ([TuneKit isEnabled]) {
        CGFloat max = MAX(2.0f, 4.f * self.mass);
        return [TuneKit addSlider:@"Mass"
                           target:self
                          keyPath:@"mass"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addStiffnessControl
{
    if ([TuneKit isEnabled]) {
        CGFloat max = MAX(100.0f, 4.f * self.stiffness);
        return [TuneKit addSlider:@"Stiffness"
                           target:self
                          keyPath:@"stiffness"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addDurationAdjustment
{
    if ([TuneKit isEnabled]) {
        CGFloat max = MAX(0.5, 4.f * self.durationAdjustment);
        return [TuneKit addSlider:@"Duration Adjustment"
                           target:self
                          keyPath:@"durationAdjustment"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKLabelConfig *)addDurationLabel
{
    if ([TuneKit isEnabled]) {
        self.durationLabelAdded = YES;
        return [TuneKit addLabel:@"Duration" target:self keyPath:@"prototype.duration"];
    }
    return nil;
}

#pragma mark - Creating builders

+ (instancetype)builder
{
    return [[TKRBBSpringAnimationBuilder alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        _prototype = [[RBBSpringAnimation alloc] init];
    }
    return self;
}

@end
