//
//  TKSliderConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKSliderConfig.h"

@interface TKSliderConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@property (strong, nonatomic) TKValueCallback changeHandler;
@end

@implementation TKSliderConfig

#pragma mark - Binding to models

- (void)setTarget:(id)target
{
    _target = target;
    [self updateTargetKeyPath];
}

- (void)setKeyPath:(NSString *)keyPath
{
    _keyPath = keyPath;
    [self updateTargetKeyPath];
}

- (void)updateTargetKeyPath
{
    if (self.target && self.keyPath.length) {
        [self.target setValue:self.value forKeyPath:self.keyPath];
    }
}

- (void)setValue:(NSNumber *)value
{
    if ((value == nil && value != nil) || ![_value isEqual:value]) {
        _value = value;
        [self updateTargetKeyPath];
        [self updateValueLabel];
        [self updateSlider];
    }
}

#pragma mark - Binding to controls

- (void)setSlider:(UISlider *)slider
{
    if (_slider != slider) {
        _slider = slider;
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)updateSlider
{
    self.slider.minimumValue = [self.minValue floatValue];
    self.slider.maximumValue = [self.maxValue floatValue];
    if (!self.value) {
        if (self.defaultValue) {
            self.value = self.defaultValue;
        } else {
            self.value = @(([self.minValue doubleValue] + [self.maxValue doubleValue]) / 2.0f);
        }
    }
    self.slider.value = [self.value floatValue];
}

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = self.name;
    }
}

- (void)setValueLabel:(UILabel *)valueLabel
{
    if (_valueLabel != valueLabel) {
        _valueLabel = valueLabel;
        [self updateValueLabel];
    }
}

- (void)sliderValueChanged:(UISlider *)slider
{
    self.value = @(slider.value);
}

- (void)updateValueLabel
{
    self.valueLabel.text = [NSString stringWithFormat:@"%@", self.value];
}

@end
