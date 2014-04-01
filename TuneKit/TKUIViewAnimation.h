//
//  TKUIViewAnimation.h
//  TuneKit
//
//  Created by Tim Moose on 3/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuneKit.h"

/**
 Plugin for `animateWithDuration:delay:options:animations:completion:`
 */

@interface TKUIViewAnimation : NSObject <NSCopying>

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) UIViewAnimationOptions easingCurve;

@property (nonatomic) UIViewAnimationOptions options;
@property (strong, nonatomic) void(^animations)(void);
@property (strong, nonatomic) void (^completion)(BOOL finished);

- (void)performAnimation;

+ (instancetype)animimation;

+ (instancetype)animimationWithName:(NSString *)name;

@end
