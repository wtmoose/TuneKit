//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <QuartzCore/QuartzCore.h>

@class TKSliderConfig;
@class TKSegmentedControlConfig;

@interface TKCAAnimationBuilder : NSObject

#pragma mark - Configuring the builder

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) NSString *mediaTimingFunctionName;

#pragma mark - Creating the animation

- (CAAnimation *)animation;

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDurationControl;
- (TKSliderConfig *)addDelayControl;
- (TKSegmentedControlConfig *)addMediaTimingFunctionNameControl;

#pragma mark - Creating builders

+ (instancetype)builder;

@end
