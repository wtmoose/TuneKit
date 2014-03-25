//
//  TKSwitchConfig.m
//  TuneKit
//
//  Created by Tim Moose on 3/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKSwitchConfig.h"
#import "TKGlobal.h"
#import "NSObject+Utils.h"
#import <TuneKit/TuneKit.h>

@interface TKSwitchConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@property (nonatomic) BOOL initialValue;
@end

@implementation TKSwitchConfig

//- (void)dealloc
//{
//    if (self.target) {
//        [self.target removeObserver:self forKeyPath:self.keyPath];
//    }
//}

#pragma mark - Model bindings

- (void)setValue:(BOOL)value
{
    if (_value != value) {
        [self setValueInternal:value];
        if (self.target) {
            [self.target setValue:@(value) forKeyPath:self.keyPath];
        }
    }
}

- (void)setValueInternal:(BOOL)value
{
    _value = value;
    if (self.defaultGroupName) {
        [TuneKit setDefaultValue:@(self.value) forIdentifier:self.identifier defaultGroup:self.defaultGroupName];
    }
    [self updateValueViews];
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    BOOL value = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
//    if (self.value != value) {
//        [self setValueInternal:value];
//    }
//}

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

#pragma mark - Default values

- (void)setDefaultGroupName:(NSString *)defaultGroup
{
    if (![NSObject nilSafeObject:self.defaultGroupName isEqual:defaultGroup]) {
        super.defaultGroupName = defaultGroup;
        
        if (defaultGroup) {
            NSNumber *defaultValue = [TuneKit defaultValueForIdentifier:self.identifier defaultGroup:defaultGroup];
            
            if (defaultValue) {
                self.value = [defaultValue boolValue];
            } else {
                [TuneKit setDefaultValue:@(self.value) forIdentifier:self.identifier defaultGroup:defaultGroup];
            }
        } else {
            self.value = self.initialValue;
        }
    }
}

#pragma mark - Creating switch configs

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    if (self = [super initWithName:name type:type identifier:identifier]) {
        _target = target;
        _keyPath = keyPath;
        self.initialValue = [[target valueForKeyPath:keyPath] boolValue];
        [self setValueInternal:self.initialValue];
        //        // observe property changes if possible
        //        @try {
        //        [target addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
        //        }
        //        @catch (NSException *exception) {
        //            // TODO log a warining?
        //        }
        //        @finally {
        //        }
    }
    return self;
}

+ (TKSwitchConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    TKSwitchConfig *config = [[TKSwitchConfig alloc] initWithName:name type:TKConfigTypeSwitch identifier:identifier target:target keyPath:keyPath];
    return config;
}

@end
