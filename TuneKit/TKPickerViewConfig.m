//  Created by Tim Moose on 3/31/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKPickerViewConfig.h"
#import "TuneKit.h"
#import "NSObject+Utils.h"

@interface TKPickerViewConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@property (copy, nonatomic) NSArray *pickerNames;
@property (copy, nonatomic) NSArray *pickerValues;
@property (nonatomic) id initialValue;
@property (nonatomic) BOOL internalIsTuned;
@end

@implementation TKPickerViewConfig

#pragma mark - Model bindings

- (void)setValue:(id)value
{
    if (_value != value) {
        [self setValueInternal:value];
        if (self.target) {
            [self.target setValue:value forKeyPath:self.keyPath];
        }
    }
}

- (void)setValueInternal:(id)value
{
    _value = value;
    if (self.defaultGroupName) {
        [TuneKit setDefaultValue:self.value forIdentifier:self.identifier defaultGroup:self.defaultGroupName];
    }
    self.internalIsTuned = ![NSObject nilSafeObject:self.value isEqual:self.initialValue];
    [self updateValueViews];
}

- (void)setInternalIsTuned:(BOOL)internalIsTuned
{
    if (_internalIsTuned != internalIsTuned) {
        _internalIsTuned = internalIsTuned;
        [[NSNotificationCenter defaultCenter] postNotificationName:kTKConfigTunedChanged object:self];
    }
}

- (BOOL)isTuned
{
    return self.internalIsTuned;
}

#pragma mark - View bindings

- (void)setPickerView:(UIPickerView *)pickerView
{
    if (_pickerView != pickerView) {
        _pickerView.delegate = nil;
        _pickerView = pickerView;
        pickerView.delegate = self;
        [pickerView reloadAllComponents];
        [self updateValueViews];
    }
}

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = [self.name uppercaseString];
    }
}

#pragma mark - Picker view

- (void)updateValueViews
{
    NSInteger index = self.value ? [self.pickerValues indexOfObject:self.value] : 0;
    [self.pickerView selectRow:index inComponent:0 animated:YES];
}

#pragma mark - Default values

- (void)setDefaultGroupName:(NSString *)defaultGroup
{
    if (![NSObject nilSafeObject:self.defaultGroupName isEqual:defaultGroup]) {
        super.defaultGroupName = defaultGroup;
        
        if (defaultGroup) {
            NSNumber *defaultValue = [TuneKit defaultValueForIdentifier:self.identifier defaultGroup:defaultGroup];
            
            if (defaultValue) {
                self.value = defaultValue;
            } else {
                [TuneKit setDefaultValue:self.value forIdentifier:self.identifier defaultGroup:defaultGroup];
            }
        } else {
            self.value = self.initialValue;
        }
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerValues count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerNames[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.value = self.pickerValues[row];
}

#pragma mark - Creating segmented control configs

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identifier
                      target:(id)target
                     keyPath:(NSString *)keyPath
                pickerNames:(NSArray *)pickerNames
               pickerValues:(NSArray *)pickerValues
{
    if (self = [super initWithName:name type:TKConfigTypePickerView identifier:identifier]) {
        _target = target;
        _keyPath = keyPath;
        _pickerNames = pickerNames;
        _pickerValues = pickerValues;
    }
    self.initialValue = [target valueForKeyPath:keyPath];
    [self setValueInternal:self.initialValue];
    return self;
}

+ (instancetype)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                pickerNames:(NSArray *)pickerNames
{
    // TODO determine the property type in deciding whether picker
    // values are numbers representing the selected index or strings
    // matching the picker names
    [NSException raise:@"TODO" format:nil];
    return nil;
}

+ (instancetype)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                pickerNames:(NSArray *)pickerNames
                               pickerValues:(NSArray *)pickerValues
{
    TKPickerViewConfig *config = [[TKPickerViewConfig alloc] initWithName:name identifier:identifier target:target keyPath:keyPath pickerNames:pickerNames pickerValues:pickerValues];
    return config;
}

@end
