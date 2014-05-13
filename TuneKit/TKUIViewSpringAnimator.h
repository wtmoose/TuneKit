//
//  TKUIViewSpringAnimator.h
//  TuneKit
//
//  Created by Tim Moose on 4/4/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

/**
 Performs a `UIView` spring animation and integrates with TuneKit.
 */

#import "TKUIViewAnimator.h"

@interface TKUIViewSpringAnimator : TKUIViewAnimator

#pragma mark - Configuring the animation

@property (nonatomic) CGFloat damping;
@property (nonatomic) CGFloat initialVelocity;

#pragma mark - Adding default TuneKit controls

- (TKSliderConfig *)addDampingControl;
- (TKSliderConfig *)addInitialVelocityControl;

@end
