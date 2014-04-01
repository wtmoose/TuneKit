//
//  TKPickerViewConfig.h
//  TuneKit
//
//  Created by Tim Moose on 3/31/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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
