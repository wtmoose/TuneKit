//  Created by Tim Moose on 5/13/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPOPDecayAnimationBuilder.h"

@implementation TKPOPDecayAnimationBuilder

#pragma mark - Creating the animation

- (POPDecayAnimation *)animation
{
    return [self animationWithPropertyNamed:nil];
}

- (POPDecayAnimation *)animationWithPropertyNamed:(NSString *)name
{
    POPDecayAnimation *animation = [POPDecayAnimation animationWithPropertyNamed:name];
    animation.beginTime = CACurrentMediaTime() + self.delay;
    animation.deceleration = self.deceleration;
    return animation;
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    if ([TuneKit isEnabled]) {
        NSMutableArray *controls = [NSMutableArray arrayWithCapacity:2];
        [controls addObjectsFromArray:[super addAllControls]];
        [controls addObject:[self addDeceleration]];
        return controls;
    }
    return nil;
}

- (TKSliderConfig *)addDeceleration
{
    if ([TuneKit isEnabled]) {
        return [TuneKit addSlider:@"Deceleration"
                           target:self
                          keyPath:@"deceleration"
                              min:0.f
                              max:1.f];
    }
    return nil;
}

#pragma mark - Creating builders

- (id)init
{
    if (self = [super init]) {
        _deceleration = 0.998f;
    }
    return self;
}

+ (instancetype)builder
{
    return [[TKPOPDecayAnimationBuilder alloc] init];
}

@end
