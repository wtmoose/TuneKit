//  Created by Tim Moose on 5/13/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPPropertyAnimationBuilder.h"

@interface TKPOPDecayAnimationBuilder : TKPOPPropertyAnimationBuilder

#pragma mark - Configuring the builder

@property (nonatomic) CGFloat deceleration;

#pragma mark - Creating the animation

- (POPDecayAnimation *)animation;
- (POPDecayAnimation *)animationWithPropertyNamed:(NSString *)name;

#pragma mark - Adding TuneKit controls

- (TKSliderConfig *)addDeceleration;

@end
