//
//  TKPOPSpringAnimationBuilder.h
//  TuneKit
//
//  Created by Tim Moose on 5/12/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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

#pragma mark - Adding default TuneKit controls

- (NSArray *)addBasicControls;

- (TKSliderConfig *)addSpringBounciness;
- (TKSliderConfig *)addSpringSpeed;
- (TKSliderConfig *)addDynamicsTension;
- (TKSliderConfig *)addDynamicsFriction;
- (TKSliderConfig *)addDynamicsMass;

@end
