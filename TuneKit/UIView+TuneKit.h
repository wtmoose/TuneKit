//  Created by Tim Moose on 4/1/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>

@class TKSegmentedControlConfig;

@interface UIView (TuneKit)

/**
 Adds a segmented control configured for selecting easing curves.
 `keyPath` should be of type `UIViewAnimationOptions`.
 */
+ (TKSegmentedControlConfig *)addAnimationEasingCurveConfig:(NSString *)name
                                                     target:(id)target
                                                    keyPath:(NSString *)keyPath;

/**
 Merges the given easing curve with other options, removing any previous
 easing curve option from the given options. Useful for tuning an easing curve
 for an animation that might have other options present.
 */
+ (UIViewAnimationOptions)mergeEasing:(UIViewAnimationOptions)easing
                      andOtherOptions:(UIViewAnimationOptions)otherOptions;

@end
