//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <QuartzCore/QuartzCore.h>
#import <AHEasing/easing.h>

extern NSString *kAHEasingLinearInterpolation;
extern NSString *kAHEasingQuadraticEaseIn;
extern NSString *kAHEasingQuadraticEaseOut;
extern NSString *kAHEasingQuadraticEaseInOut;
extern NSString *kAHEasingCubicEaseIn;
extern NSString *kAHEasingCubicEaseOut;
extern NSString *kAHEasingCubicEaseInOut;
extern NSString *kAHEasingQuarticEaseIn;
extern NSString *kAHEasingQuarticEaseOut;
extern NSString *kAHEasingQuarticEaseInOut;
extern NSString *kAHEasingQuinticEaseIn;
extern NSString *kAHEasingQuinticEaseOut;
extern NSString *kAHEasingQuinticEaseInOut;
extern NSString *kAHEasingExponentialEaseIn;
extern NSString *kAHEasingExponentialEaseOut;
extern NSString *kAHEasingExponentialEaseInOut;
extern NSString *kAHEasingBounceEaseIn;
extern NSString *kAHEasingBounceEaseOut;
extern NSString *kAHEasingBounceEaseInOut;
extern NSString *kAHEasingSineEaseIn;
extern NSString *kAHEasingSineEaseOut;
extern NSString *kAHEasingSineEaseInOut;
extern NSString *kAHEasingCircularEaseIn;
extern NSString *kAHEasingCircularEaseOut;
extern NSString *kAHEasingCircularEaseInOut;
extern NSString *kAHEasingElasticEaseIn;
extern NSString *kAHEasingElasticEaseOut;
extern NSString *kAHEasingElasticEaseInOut;
extern NSString *kAHEasingBackEaseIn;
extern NSString *kAHEasingBackEaseOut;
extern NSString *kAHEasingBackEaseInOut;

@class TKPickerViewConfig;

@interface CAKeyframeAnimation (AHEasingTuneKit)

/**
 Adds a picker view configured for selecting `AHEasingFunctions` by name.
 `keyPath` should be of type `NSString`.
 */
+ (TKPickerViewConfig *)addAHEasingFunctionNameConfig:(NSString *)name
                                               target:(id)target
                                              keyPath:(NSString *)keyPath;

/**
 */
+  (AHEasingFunction)easingFunctionForName:(NSString *)easingFunctionName;

@end
