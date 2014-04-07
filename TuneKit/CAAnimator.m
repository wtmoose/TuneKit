//
//  CAAnimator.m
//  TuneKit
//
//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "CAAnimator.h"
#import "TuneKit.h"
#import "CAAnimation+TuneKit.h"

@implementation CAAnimator

#pragma mark - Creating the animation

- (CAAnimation *)animation
{
    return nil; // TODO raise exception?
}

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:3];
        [controls addObject:[self addDurationControl]];
        [controls addObject:[self addDelayControl]];
        [controls addObject:[self addMediaTimingFunctionNameControl]];
        return controls;
    }
    return nil;
}

- (TKSliderConfig *)addDurationControl
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.duration);
        return [TuneKit addSlider:TKPluginName(self.namePrefix, @"Duration")
                           target:self
                          keyPath:@"duration"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSliderConfig *)addDelayControl
{
    if ([TuneKit isEnabled]) {
        NSTimeInterval max = MAX(.5f, 2.f * self.delay);
        return [TuneKit addSlider:TKPluginName(self.namePrefix, @"Delay")
                           target:self
                          keyPath:@"delay"
                              min:0.f
                              max:max];
    }
    return nil;
}

- (TKSegmentedControlConfig *)addMediaTimingFunctionNameControl
{
    if ([TuneKit isEnabled]) {
        return [CAAnimation addMediaTimingFunctionNameConfig:TKPluginName(self.namePrefix, @"Easing")
                                                  target:self
                                                 keyPath:@"mediaTimingFunctionName"];
    }
    return nil;
}

#pragma mark - Creating animators

+ (instancetype)animimator
{
    return nil;// TODO raise exception?
}

+ (instancetype)animimatorWithNamePrefix:(NSString *)name
{
    return nil;// TODO raise exception?
}

- (instancetype)initWithNamePrefix:(NSString *)namePrefix
{
    if (self = [super init]) {
        _namePrefix = namePrefix;
        _mediaTimingFunctionName = kCAMediaTimingFunctionDefault;
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    CAAnimator *copy = [[[self class] alloc] init];
    copy.duration = self.duration;
    copy.delay = self.delay;
    copy.mediaTimingFunctionName = self.mediaTimingFunctionName;
    return copy;
}

@end
