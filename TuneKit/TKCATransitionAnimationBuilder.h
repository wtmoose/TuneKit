//
//  TKCATransitionAnimationBuilder.h
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKCAAnimationBuilder.h"

@interface TKCATransitionAnimationBuilder : TKCAAnimationBuilder

#pragma mark - Creating the animation

- (CATransition *)animation;

@end