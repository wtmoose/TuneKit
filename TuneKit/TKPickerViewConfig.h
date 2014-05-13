//  Created by Tim Moose on 3/31/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKPickerViewConfig : TKConfig <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) id value;
@property (readonly, copy, nonatomic) NSArray *pickerValues;

#pragma mark - View bindings

@property (weak, nonatomic) UIPickerView *pickerView;
@property (weak, nonatomic) UILabel *nameLabel;

#pragma mark - Creating segmented control configs

+ (TKPickerViewConfig *)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                pickerNames:(NSArray *)pickerNames;

+ (TKPickerViewConfig *)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                pickerNames:(NSArray *)pickerNames
                               pickerValues:(NSArray *)pickerValues;

@end
