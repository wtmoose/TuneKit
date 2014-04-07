//
//  CAAnimation+TuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 4/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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
