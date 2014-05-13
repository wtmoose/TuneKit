//
//  TKAHEasingAnimationBuilder.h
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 tractablelabs.com. All rights reserved.
//

#import <TuneKit/TuneKit.h>

@interface TKAHEasingAnimationBuilder : TKCAKeyFrameAnimationBuilder

#pragma mark - Configuring the animator

@property (strong, nonatomic) NSString *easingFunctionName;
@property (nonatomic) NSInteger numberOfKeyframes;


#pragma mark - Creating the animation

- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;
- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;
- (CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath fromSize:(CGSize)fromSize toSize:(CGSize)toSize;

#pragma mark - Adding default TuneKit controls

- (TKPickerViewConfig *)addEasingFunctionNameControl;
- (TKSliderConfig *)addNumberOfKeyframesControl;

@end
