//
//  TKRBBSpringAnimationBuilder.h
//  TuneKit
//
//  Created by Tim Moose on 4/18/15.
//  Copyright (c) 2015 Tractable Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RBBAnimation/RBBSpringAnimation.h>
#import "TuneKit.h"

@interface TKRBBSpringAnimationBuilder : NSObject

#pragma mark - Configuring the builder

@property (nonatomic) CGFloat damping;
@property (nonatomic) CGFloat mass;
@property (nonatomic) CGFloat stiffness;
@property (readonly, nonatomic) CGFloat duration;

#pragma mark - Creating the animation

- (RBBSpringAnimation *)animation;

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDampingControl;
- (TKSliderConfig *)addMassControl;
- (TKSliderConfig *)addStiffnessControl;
- (TKSliderConfig *)addVelocityControl;
- (TKLabelConfig *)addDurationLabel;

#pragma mark - Creating builders

+ (instancetype)builder;

@end
