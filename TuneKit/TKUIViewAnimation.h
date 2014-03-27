//
//  TKUIViewAnimation.h
//  TuneKit
//
//  Created by Tim Moose on 3/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuneKit.h"
#import "TKPlugin.h"

/**
 Plugin for `animateWithDuration:delay:options:animations:completion:`
 */

@interface TKUIViewAnimation : NSObject <TKPlugin>

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) UIViewAnimationOptions easingCurve;

@property (nonatomic) UIViewAnimationOptions options;
@property (strong, nonatomic) void(^animations)(void);
@property (strong, nonatomic) void (^completion)(BOOL finished);

- (void)setDuration:(NSTimeInterval)duration min:(NSTimeInterval)min max:(NSTimeInterval)max;
- (void)setDelay:(NSTimeInterval)delay min:(NSTimeInterval)min max:(NSTimeInterval)max;

- (void)performAnimation;

+ (instancetype)viewAnimimation;

+ (instancetype)viewAnimimationWithName:(NSString *)name;

@end
