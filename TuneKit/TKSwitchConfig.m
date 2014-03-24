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

#pragma mark - Model bindings

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

+ (TKSwitchConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    NSNumber *value = [target valueForKeyPath:keyPath];
    __weak id weakTarget = target;
    return [self configWithName:name identifier:identifier changeHandler:^(id value) {
        [weakTarget setValue:value forKeyPath:keyPath];
    } value:[value boolValue]];
    
}

+ (TKSwitchConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier changeHandler:(TKValueCallback)changeHandler value:(BOOL)value
{
    TKSwitchConfig *config = [[TKSwitchConfig alloc] initWithName:name type:TKConfigTypeSwitch identifier:identifier];
    config.changeHandler = changeHandler;
    config.value = value;
    return config;
}

@end
