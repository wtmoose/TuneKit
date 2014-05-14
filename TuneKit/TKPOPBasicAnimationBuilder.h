//  Created by Tim Moose on 5/13/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPPropertyAnimationBuilder.h"

@interface TKPOPBasicAnimationBuilder : TKPOPPropertyAnimationBuilder

#pragma mark - Configuring the builder

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSString *mediaTimingFunctionName;

#pragma mark - Creating the animation

- (POPBasicAnimation *)animation;
- (POPBasicAnimation *)animationWithPropertyNamed:(NSString *)name;

#pragma mark - Adding TuneKit controls

- (TKSliderConfig *)addDurationControl;
- (TKSegmentedControlConfig *)addMediaTimingFunctionNameControl;

#pragma mark - Creating builders

+ (instancetype)builder;

@end
