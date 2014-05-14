//  Created by Tim Moose on 5/12/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPSpringAnimationBuilder.h"

@interface TKPOPSpringAnimationBuilder ()
@end

@implementation TKPOPSpringAnimationBuilder

#pragma mark - Creating the animation

- (POPSpringAnimation *)animation
{
    return [self animationWithPropertyNamed:nil];
}

- (POPSpringAnimation *)animationWithPropertyNamed:(NSString *)name
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:name];
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.springBounciness = self.springBounciness;
    animation.springSpeed = self.springSpeed;
    if (self.dynamicsTension > 0) {
        animation.dynamicsTension = self.dynamicsTension;
    }
    if (self.dynamicsFriction > 0) {
        animation.dynamicsFriction = self.dynamicsFriction;
    }
    if (self.dynamicsMass > 0) {
        animation.dynamicsMass = self.dynamicsMass;
    }
    return animation;
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:6];
        [controls addObjectsFromArray:[super addAllControls]];
        [controls addObject:[self addSpringBounciness]];
        [controls addObject:[self addSpringSpeed]];
        [controls addObject:[self addDynamicsTension]];
        [controls addObject:[self addDynamicsFriction]];
        [controls addObject:[self addDynamicsMass]];
        return controls;
    }
    return nil;
}

- (NSArray *)addBasicControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:6];
        [controls addObjectsFromArray:[super addAllControls]];
        [controls addObject:[self addSpringBounciness]];
        [controls addObject:[self addSpringSpeed]];
        return controls;
    }
    return nil;
}

- (TKSliderConfig *)addSpringBounciness
{
    if ([TuneKit isEnabled]) {
        return [TuneKit addSlider:@"Spring Bounciness"
                           target:self
                          keyPath:@"springBounciness"
                              min:0.f
                              max:20.f];
    }
    return nil;
}

- (TKSliderConfig *)addSpringSpeed
{
    if ([TuneKit isEnabled]) {
        return [TuneKit addSlider:@"Spring Speed"
                           target:self
                          keyPath:@"springSpeed"
                              min:0.f
                              max:20.f];
    }
    return nil;
}

- (TKSliderConfig *)addDynamicsTension
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.dynamicsTension);
        return [TuneKit addSlider:@"Dynamics Tension"
                           target:self
                          keyPath:@"dynamicsTension"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addDynamicsFriction
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.dynamicsFriction);
        return [TuneKit addSlider:@"Dynamics Friction"
                           target:self
                          keyPath:@"dynamicsFriction"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addDynamicsMass
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.dynamicsMass);
        return [TuneKit addSlider:@"Dynamics Mass"
                           target:self
                          keyPath:@"dynamicsMass"
                              min:0.f
                              max:max];
    }
    return nil;
}

#pragma mark - Creating builders

- (id)init
{
    if (self = [super init]) {
        _springBounciness = 4.f;
        _springSpeed = 12.f;
    }
    return self;
}

+ (instancetype)builder
{
    return [[TKPOPSpringAnimationBuilder alloc] init];
}

@end
