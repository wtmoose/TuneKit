//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <QuartzCore/QuartzCore.h>

@class TKSegmentedControlConfig;

@interface CAAnimation (TuneKit)

/**
 Adds a segmented control configured for selecting media timing functions by name.
 `keyPath` should be of type `NSString`.
 */
+ (TKSegmentedControlConfig *)addMediaTimingFunctionNameConfig:(NSString *)name
                                                     target:(id)target
                                                    keyPath:(NSString *)keyPath;

@end
