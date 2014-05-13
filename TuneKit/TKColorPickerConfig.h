//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKColorPickerConfig : TKConfig

@property (nonatomic) UIColor *value;

#pragma mark - View bindings

@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UISegmentedControl *colorSpacePicker;
@property (weak, nonatomic) UITextField *hexTextField;
@property (strong, nonatomic) NSArray *sliders;
@property (strong, nonatomic) NSArray *sliderLabels;
@property (strong, nonatomic) NSArray *sliderValues;
@property (weak, nonatomic) UIView *currentColorView;
@property (weak, nonatomic) UIView *updatedColorView;

#pragma mark - Creating color picker configs

+ (instancetype)configWithName:(NSString *)name
                             identifier:(NSString *)identifier
                                 target:(id)target
                                keyPath:(NSString *)keyPath;

@end
