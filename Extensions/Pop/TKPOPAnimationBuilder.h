//  Created by Tim Moose on 5/12/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <Foundation/Foundation.h>
#import <pop/POP.h>
#import "TuneKit.h"

@interface TKPOPAnimationBuilder : NSObject

#pragma mark - Configuring the builder

@property (nonatomic) NSTimeInterval delay;

#pragma mark - Creating the animation

- (POPAnimation *)animation;

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDelayControl;

#pragma mark - Creating builders

+ (instancetype)builder;

@end
