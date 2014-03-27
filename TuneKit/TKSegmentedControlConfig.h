//
//  TKSegmentedControlConfig.h
//  TuneKit
//
//  Created by Tim Moose on 3/26/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKSegmentedControlConfig : TKConfig

@property (nonatomic) id value;
@property (readonly, copy, nonatomic) NSArray *segmentValues;

#pragma mark - View bindings

@property (weak, nonatomic) UISegmentedControl *segmentedControl;
@property (weak, nonatomic) UILabel *nameLabel;

#pragma mark - Creating segmented control configs

+ (TKSegmentedControlConfig *)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                segmentNames:(NSArray *)segmentNames;

+ (TKSegmentedControlConfig *)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                segmentNames:(NSArray *)segmentNames
                               segmentValues:(NSArray *)segmentValues;

@end
