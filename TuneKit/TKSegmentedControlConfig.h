//  Created by Tim Moose on 3/26/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKSegmentedControlConfig : TKConfig

@property (nonatomic) id value;
@property (readonly, copy, nonatomic) NSArray *segmentValues;

#pragma mark - View bindings

@property (weak, nonatomic) UISegmentedControl *segmentedControl;
@property (weak, nonatomic) UILabel *nameLabel;

#pragma mark - Creating segmented control configs

+ (instancetype)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                segmentNames:(NSArray *)segmentNames;

+ (instancetype)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                segmentNames:(NSArray *)segmentNames
                               segmentValues:(NSArray *)segmentValues;

@end
