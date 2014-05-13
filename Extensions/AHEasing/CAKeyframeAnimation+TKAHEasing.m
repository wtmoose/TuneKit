//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

NSString *kAHEasingLinearInterpolation = @"Linear Interpolation";
NSString *kAHEasingQuadraticEaseIn = @"Quadratic Ease In";
NSString *kAHEasingQuadraticEaseOut = @"Quadratic Ease Out";
NSString *kAHEasingQuadraticEaseInOut = @"Quadratic Ease InOut";
NSString *kAHEasingCubicEaseIn = @"Cubic Ease In";
NSString *kAHEasingCubicEaseOut = @"Cubic Ease Out";
NSString *kAHEasingCubicEaseInOut = @"Cubic Ease InOut";
NSString *kAHEasingQuarticEaseIn = @"Quartic Ease In";
NSString *kAHEasingQuarticEaseOut = @"Quartic Ease Out";
NSString *kAHEasingQuarticEaseInOut = @"Quartic Ease InOut";
NSString *kAHEasingQuinticEaseIn = @"Quintic Ease In";
NSString *kAHEasingQuinticEaseOut = @"Quintic Ease Out";
NSString *kAHEasingQuinticEaseInOut = @"Quintic Ease InOut";
NSString *kAHEasingExponentialEaseIn = @"Exponential Ease In";
NSString *kAHEasingExponentialEaseOut = @"Exponential Ease Out";
NSString *kAHEasingExponentialEaseInOut = @"Exponential Ease InOut";
NSString *kAHEasingBounceEaseIn = @"BounceEase In";
NSString *kAHEasingBounceEaseOut = @"BounceEase Out";
NSString *kAHEasingBounceEaseInOut = @"Bounce Ease InOut";
NSString *kAHEasingSineEaseIn = @"Sine Ease In";
NSString *kAHEasingSineEaseOut = @"Sine Ease Out";
NSString *kAHEasingSineEaseInOut = @"Sine Ease InOut";
NSString *kAHEasingCircularEaseIn = @"Circular Ease In";
NSString *kAHEasingCircularEaseOut = @"Circular Ease Out";
NSString *kAHEasingCircularEaseInOut = @"Circular Ease InOut";
NSString *kAHEasingElasticEaseIn = @"Elastic Ease In";
NSString *kAHEasingElasticEaseOut = @"Elastic Ease Out";
NSString *kAHEasingElasticEaseInOut = @"Elastic Ease InOut";
NSString *kAHEasingBackEaseIn = @"Back Ease In";
NSString *kAHEasingBackEaseOut = @"Back Ease Out";
NSString *kAHEasingBackEaseInOut = @"Back Ease InOut";

#import "CAKeyframeAnimation+TKAHEasing.h"
#import "TuneKit.h"

@implementation CAKeyframeAnimation (TKAHEasing)

+ (TKPickerViewConfig *)addAHEasingFunctionNameConfig:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    static NSArray *names;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        names = @[
           kAHEasingLinearInterpolation,
           kAHEasingQuadraticEaseIn,
           kAHEasingQuadraticEaseOut,
           kAHEasingQuadraticEaseInOut,
           kAHEasingCubicEaseIn,
           kAHEasingCubicEaseOut,
           kAHEasingCubicEaseInOut,
           kAHEasingQuarticEaseIn,
           kAHEasingQuarticEaseOut,
           kAHEasingQuarticEaseInOut,
           kAHEasingQuinticEaseIn,
           kAHEasingQuinticEaseOut,
           kAHEasingQuinticEaseInOut,
           kAHEasingExponentialEaseIn,
           kAHEasingExponentialEaseOut,
           kAHEasingExponentialEaseInOut,
           kAHEasingBounceEaseIn,
           kAHEasingBounceEaseOut,
           kAHEasingBounceEaseInOut,
           kAHEasingSineEaseIn,
           kAHEasingSineEaseOut,
           kAHEasingSineEaseInOut,
           kAHEasingCircularEaseIn,
           kAHEasingCircularEaseOut,
           kAHEasingCircularEaseInOut,
           kAHEasingElasticEaseIn,
           kAHEasingElasticEaseOut,
           kAHEasingElasticEaseInOut,
           kAHEasingBackEaseIn,
           kAHEasingBackEaseOut,
           kAHEasingBackEaseInOut];
    });
    return [TuneKit addPickerView:name target:target keyPath:keyPath pickerNames:names pickerValues:names];
}

+ (AHEasingFunction)easingFunctionForName:(NSString *)easingFunctionName
{
    static NSDictionary *easingFunctionsByName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        easingFunctionsByName = @{
          kAHEasingLinearInterpolation : [NSValue valueWithPointer:LinearInterpolation],
          kAHEasingQuadraticEaseIn : [NSValue valueWithPointer:QuadraticEaseIn],
          kAHEasingQuadraticEaseOut : [NSValue valueWithPointer:QuadraticEaseOut],
          kAHEasingQuadraticEaseInOut : [NSValue valueWithPointer:QuadraticEaseInOut],
          kAHEasingCubicEaseIn : [NSValue valueWithPointer:CubicEaseIn],
          kAHEasingCubicEaseOut : [NSValue valueWithPointer:CubicEaseOut],
          kAHEasingCubicEaseInOut : [NSValue valueWithPointer:CubicEaseInOut],
          kAHEasingQuarticEaseIn : [NSValue valueWithPointer:QuarticEaseIn],
          kAHEasingQuarticEaseOut : [NSValue valueWithPointer:QuarticEaseOut],
          kAHEasingQuarticEaseInOut : [NSValue valueWithPointer:QuarticEaseInOut],
          kAHEasingQuinticEaseIn : [NSValue valueWithPointer:QuinticEaseIn],
          kAHEasingQuinticEaseOut : [NSValue valueWithPointer:QuinticEaseOut],
          kAHEasingQuinticEaseInOut : [NSValue valueWithPointer:QuinticEaseInOut],
          kAHEasingExponentialEaseIn : [NSValue valueWithPointer:ExponentialEaseIn],
          kAHEasingExponentialEaseOut : [NSValue valueWithPointer:ExponentialEaseOut],
          kAHEasingExponentialEaseInOut : [NSValue valueWithPointer:ExponentialEaseInOut],
          kAHEasingBounceEaseIn : [NSValue valueWithPointer:BounceEaseIn],
          kAHEasingBounceEaseOut : [NSValue valueWithPointer:BounceEaseOut],
          kAHEasingBounceEaseInOut : [NSValue valueWithPointer:BounceEaseInOut],
          kAHEasingSineEaseIn : [NSValue valueWithPointer:SineEaseIn],
          kAHEasingSineEaseOut : [NSValue valueWithPointer:SineEaseOut],
          kAHEasingSineEaseInOut : [NSValue valueWithPointer:SineEaseInOut],
          kAHEasingCircularEaseIn : [NSValue valueWithPointer:CircularEaseIn],
          kAHEasingCircularEaseOut : [NSValue valueWithPointer:CircularEaseOut],
          kAHEasingCircularEaseInOut : [NSValue valueWithPointer:CircularEaseInOut],
          kAHEasingElasticEaseIn : [NSValue valueWithPointer:ElasticEaseIn],
          kAHEasingElasticEaseOut : [NSValue valueWithPointer:ElasticEaseOut],
          kAHEasingElasticEaseInOut : [NSValue valueWithPointer:ElasticEaseInOut],
          kAHEasingBackEaseIn : [NSValue valueWithPointer:BackEaseIn],
          kAHEasingBackEaseOut : [NSValue valueWithPointer:BackEaseOut],
          kAHEasingBackEaseInOut : [NSValue valueWithPointer:BackEaseInOut]};
    });
    NSValue *easingFunction = [easingFunctionsByName objectForKey:easingFunctionName];
    return [easingFunction pointerValue];
}

@end
