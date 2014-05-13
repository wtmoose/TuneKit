//  Created by Tim Moose on 3/26/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKSegmentedControlConfig.h"
#import "TuneKit.h"
#import "NSObject+Utils.h"

@interface TKSegmentedControlConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@property (copy, nonatomic) NSArray *segmentNames;
@property (copy, nonatomic) NSArray *segmentValues;
@property (nonatomic) id initialValue;
@property (nonatomic) BOOL internalIsTuned;
@end

@implementation TKSegmentedControlConfig

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

- (void)setSegmentedControl:(UISegmentedControl *)segmentedControl
{
    if (_segmentedControl != segmentedControl) {
        _segmentedControl = segmentedControl;
        [self updateSegments];
        [self updateValueViews];
        [segmentedControl addTarget:self action:@selector(controlValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = [self.name uppercaseString];
    }
}

#pragma mark - Segmented control

- (void)controlValueChanged:(UISegmentedControl *)control
{
    NSInteger index = control.selectedSegmentIndex;
    self.value = index >= 0 ? self.segmentValues[index] : nil;
}

- (void)updateSegments
{
    [self.segmentedControl removeAllSegments];
    for (int i = 0; i < [self.segmentNames count]; i++) {
        [self.segmentedControl insertSegmentWithTitle:self.segmentNames[i] atIndex:i animated:NO];
    }
}

- (void)updateValueViews
{
    NSInteger index = self.value ? [self.segmentValues indexOfObject:self.value] : NSNotFound;
    self.segmentedControl.selectedSegmentIndex = index >= 0 ? index : -1;
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

#pragma mark - Creating segmented control configs

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *)identifier
                      target:(id)target
                     keyPath:(NSString *)keyPath
                segmentNames:(NSArray *)segmentNames
               segmentValues:(NSArray *)segmentValues
{
    if (self = [super initWithName:name type:TKConfigTypeSegmentedControl identifier:identifier]) {
        _target = target;
        _keyPath = keyPath;
        _segmentNames = segmentNames;
        _segmentValues = segmentValues;
    }
    self.initialValue = [target valueForKeyPath:keyPath];
    [self setValueInternal:self.initialValue];
    return self;
}

+ (instancetype)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                segmentNames:(NSArray *)segmentNames
{
    // TODO determine the property type in deciding whether segment
    // values are numbers representing the selected index or strings
    // matching the segment names
    [NSException raise:@"TODO" format:nil];
    return nil;
}

+ (instancetype)configWithName:(NSString *)name
                                  identifier:(NSString *)identifier
                                      target:(id)target
                                     keyPath:(NSString *)keyPath
                                segmentNames:(NSArray *)segmentNames
                               segmentValues:(NSArray *)segmentValues
{
    TKSegmentedControlConfig *config = [[TKSegmentedControlConfig alloc] initWithName:name identifier:identifier target:target keyPath:keyPath segmentNames:segmentNames segmentValues:segmentValues];
    return config;
}

@end
