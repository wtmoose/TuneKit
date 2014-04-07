//
//  CAAnimator.h
//  TuneKit
//
//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class TKSliderConfig;
@class TKSegmentedControlConfig;

@interface CAAnimator : NSObject <NSCopying>

#pragma mark - Configuring the animator

@property (strong, nonatomic) NSString *namePrefix;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) NSString *mediaTimingFunctionName;

#pragma mark - Creating the animation

- (CAAnimation *)animation;

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDurationControl;
- (TKSliderConfig *)addDelayControl;
- (TKSegmentedControlConfig *)addMediaTimingFunctionNameControl;

#pragma mark - Creating animators

+ (instancetype)animimator;

+ (instancetype)animimatorWithNamePrefix:(NSString *)name;

- (instancetype)initWithNamePrefix:(NSString *)namePrefix;

@end