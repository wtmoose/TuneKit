//  Created by Tim Moose on 3/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>

@class TKSliderConfig;
@class TKSegmentedControlConfig;

/**
 Performs a basic `UIView` animation and integrates with TuneKit.
 */

@interface TKUIViewAnimator : NSObject <NSCopying>

#pragma mark - Configuring the animator

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) UIViewAnimationOptions easing;
@property (nonatomic) UIViewAnimationOptions options;

#pragma mark - Performing the animation

- (void)animateWithAnimations:(void(^)(void))animations;

- (void)animateWithAnimations:(void(^)(void))animations
               withCompletion:(void(^)(BOOL finished))completion;

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDurationControl;
- (TKSliderConfig *)addDelayControl;
- (TKSegmentedControlConfig *)addEasingControl;

#pragma mark - Creating animators

+ (instancetype)animator;

@end
