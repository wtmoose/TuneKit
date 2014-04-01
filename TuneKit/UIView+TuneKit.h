//
//  UIView+TuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 4/1/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuneKit.h"

@interface UIView (TuneKit)

+ (TKSegmentedControlConfig *)addAnimationEasingCurveConfig:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

@end
