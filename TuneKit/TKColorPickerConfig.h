//
//  TKColorPickerConfig.h
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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

+ (TKColorPickerConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath;

@end
