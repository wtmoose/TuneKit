//  Created by Tim Moose on 5/12/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPPropertyAnimationBuilder.h"

@interface TKPOPSpringAnimationBuilder : TKPOPPropertyAnimationBuilder

#pragma mark - Configuring the builder

@property (nonatomic) CGFloat springBounciness;
@property (nonatomic) CGFloat springSpeed;
@property (nonatomic) CGFloat dynamicsTension;
@property (nonatomic) CGFloat dynamicsFriction;
@property (nonatomic) CGFloat dynamicsMass;

#pragma mark - Creating the animation

- (POPSpringAnimation *)animation;
- (POPSpringAnimation *)animationWithPropertyNamed:(NSString *)name;

#pragma mark - Adding TuneKit controls

/**
 Adds delay, bounciness and speed only
 */
- (NSArray *)addBasicControls;

- (TKSliderConfig *)addSpringBounciness;
- (TKSliderConfig *)addSpringSpeed;
- (TKSliderConfig *)addDynamicsTension;
- (TKSliderConfig *)addDynamicsFriction;
- (TKSliderConfig *)addDynamicsMass;

@end
