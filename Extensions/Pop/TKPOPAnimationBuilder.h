//
//  TKPOPAnimationBuilder.h
//  TuneKit
//
//  Created by Tim Moose on 5/12/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pop/POP.h>
#import "TuneKit.h"

@interface TKPOPAnimationBuilder : NSObject

#pragma mark - Configuring the builder

@property (nonatomic) NSTimeInterval delay;

#pragma mark - Creating the animation

- (POPAnimation *)animation;

#pragma mark - Adding default TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDelayControl;

#pragma mark - Creating builders

+ (instancetype)builder;

@end
