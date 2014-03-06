//
//  TKSwitchConfig.m
//  TuneKit
//
//  Created by Tim Moose on 3/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKSwitchConfig.h"
#import "TKGlobal.h"

@interface TKSwitchConfig ()
@property (strong, nonatomic) TKValueCallback changeHandler;
@end

@implementation TKSwitchConfig

#pragma mark - Binding to models

- (void)setValue:(BOOL)value
{
    if (_value != value) {
        _value = value;
        [self updateValueViews];
        if (self.changeHandler) {
            self.changeHandler(@(value));
        }
    }
}

#pragma mark - View bindings

- (void)setTheSwitch:(UISwitch *)theSwitch
{
    if (_theSwitch != theSwitch) {
        _theSwitch = theSwitch;
        [self updateValueViews];
        [theSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = [self.name uppercaseString];
    }
}

#pragma mark - Switch

- (void)switchValueChanged:(UISwitch *)theSwitch
{
    self.value = theSwitch.isOn;
}

- (void)updateValueViews
{
    [self.theSwitch setOn:self.value animated:YES];
}

#pragma mark - Creating switch configs

+ (TKSwitchConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    NSNumber *value = [target valueForKeyPath:keyPath];
    return [self configWithName:name changeHandler:^(id value) {
        [target setValue:value forKeyPath:keyPath];
    } value:[value boolValue]];
    
}

+ (TKSwitchConfig *)configWithName:(NSString *)name changeHandler:(TKValueCallback)changeHandler value:(BOOL)value
{
    TKSwitchConfig *config = [[TKSwitchConfig alloc] initWithName:name type:TKConfigTypeSlider];
    config.changeHandler = changeHandler;
    config.value = value;
    return config;
}

@end
