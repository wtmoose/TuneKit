//  Created by Tim Moose on 4/4/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

/**
 Performs a `UIView` spring animation and integrates with TuneKit.
 */

#import "TKUIViewAnimator.h"

@interface TKUIViewSpringAnimator : TKUIViewAnimator

#pragma mark - Configuring the animation

@property (nonatomic) CGFloat damping;
@property (nonatomic) CGFloat initialVelocity;

#pragma mark - Adding TuneKit controls

- (TKSliderConfig *)addDampingControl;
- (TKSliderConfig *)addInitialVelocityControl;

@end
