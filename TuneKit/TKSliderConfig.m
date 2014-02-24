//
//  TKSliderConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKSliderConfig.h"

@interface TKSliderConfig ()
@property (strong, nonatomic) TKValueCallback changeHandler;
@property (nonatomic) float midValue;
@end

@implementation TKSliderConfig

- (void)dealloc
{
    NSLog(@"dealloc'ed TKSliderConfig");
}

#pragma mark - Binding to models

- (void)setValue:(float)value
{
    if (_value != value) {
        _value = value;
        [self updateValueLabel];
        if (self.changeHandler) {
            self.changeHandler(@(value));
        }
    }
}

#pragma mark - View bindings

- (void)setSlider:(UISlider *)slider
{
    if (_slider != slider) {
        _slider = slider;
        slider.minimumValue = 0.f;
        slider.maximumValue = 1.f;
        [self updateSliderScale:NO];
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [slider addTarget:self action:@selector(sliderValueStoppedChanging:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
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

#pragma mark - Slider

- (void)sliderValueChanged:(UISlider *)slider
{
    //TODO replace this with some kind of logarithmic function
    float constant = 0.f;
    if (fabs(self.midValue) < 10.f) {
        constant = 5.f;
    } else if (fabs(self.midValue) < 100.f) {
        constant = 50.f;
    } else if (fabs(self.midValue) < 1000.f) {
        constant = 500.f;
    } else {
        constant = 5000.f;
    }
    self.value = self.midValue + constant * (slider.value - 0.5f) * 2.f;
}

- (void)sliderValueStoppedChanging:(UISlider *)slider
{
    [self updateSliderScale:YES];
}

- (void)updateSliderScale:(BOOL)animated
{
    self.midValue = self.value;
    [self.slider setValue:0.5f animated:animated];
}

- (void)updateValueLabel
{
    NSString *format = @"%0.0f";
    if (fabs(self.value) < 100.f) {
        format = @"%0.2f";
    } else if (fabs(self.value) < 1000.f) {
        format = @"%0.1f";
    }
    self.valueLabel.text = [NSString stringWithFormat:format, self.value];
}

#pragma mark - Creating slider configs

+ (TKSliderConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    NSNumber *value = [target valueForKeyPath:keyPath];
    return [self configWithName:name changeHandler:^(id value) {
        [target setValue:value forKeyPath:keyPath];
    } value:[value floatValue]];
}

+ (TKSliderConfig *)configWithName:(NSString *)name changeHandler:(TKValueCallback)changeHandler value:(float)value
{
    TKSliderConfig *config = [[TKSliderConfig alloc] initWithName:name type:TKConfigTypeSlider];
    config.changeHandler = changeHandler;
    config.value = value;
    return config;
}

@end
