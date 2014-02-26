//
//  TKColorPickerConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKColorPickerConfig.h"

@interface TKColorPickerConfig ()
@property (strong, nonatomic) TKValueCallback changeHandler;
@end

@implementation TKColorPickerConfig

#pragma mark - Binding to models

- (void)setValue:(UIColor *)value
{
    if (_value != value) {
        _value = value;
        [self updateSliderValuesAndLabels];
        if (self.changeHandler) {
            self.changeHandler(value);
        }
    }
}

#pragma mark - View bindings

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = self.name;
    }
}

- (void)setColorSpacePicker:(UISegmentedControl *)colorSpacePicker
{
    _colorSpacePicker = colorSpacePicker;
    [colorSpacePicker addTarget:self action:@selector(updateSliderValuesAndLabels) forControlEvents:UIControlEventValueChanged];
}

- (void)setSliderLabels:(NSArray *)sliderLabels
{
    _sliderLabels = sliderLabels;
    [self updateSliderValuesAndLabels];
}

- (void)setSliders:(NSArray *)sliders
{
    _sliders = sliders;
    for (UISlider *slider in sliders) {
        slider.minimumValue = 0.f;
        slider.maximumValue = 1.f;
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [slider addTarget:self action:@selector(sliderValueStoppedChanging:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    [self updateSliderValuesAndLabels];
}

- (void)setSliderValues:(NSArray *)sliderValues
{
    _sliderValues = sliderValues;
    [self updateSliderValuesAndLabels];
}

- (void)setCurrentColorView:(UIView *)currentColorView
{
    _currentColorView = currentColorView;
    [self updateCurrentColor];
}

- (void)setUpdatedColorView:(UIView *)newColorView
{
    _updatedColorView = newColorView;
    [self updateNewColor];
}

#pragma mark - Sliders

- (void)sliderValueChanged:(UISlider *)slider
{
    [self updateNewColor];
}

- (void)sliderValueStoppedChanging:(UISlider *)slider
{
    [self commitNewColor];
}

- (void)updateSliderValuesAndLabels
{
    CGFloat v1 = 0, v2 = 0, v3 = 0, v4 = 0;
    NSArray *labels = nil;
    switch (self.colorSpacePicker.selectedSegmentIndex) {
        case 0:
            [self.value getRed:&v1 green:&v2 blue:&v3 alpha:&v4];
            labels = @[@"R", @"G", @"B", @"A"];
            break;
        case 1:
            [self.value getHue:&v1 saturation:&v2 brightness:&v3 alpha:&v4];
            labels = @[@"H", @"S", @"B", @"A"];
            break;
        default:
            break;
    }
    NSArray *components = @[@(v1), @(v2), @(v3), @(v4)];
    for (int i = 0; i < 4; i++) {
        UISlider *slider = self.sliders[i];
        UILabel *sliderValue = self.sliderValues[i];
        UILabel *sliderLabel = self.sliderLabels[i];
        [slider setValue:[components[i] floatValue] animated:YES];
        sliderValue.text = [NSString stringWithFormat:@"%.0f", roundf([components[i] floatValue] * 255.f)];
        sliderLabel.text = labels[i];
    }
}

#pragma mark - Colors

- (void)updateCurrentColor
{
    self.currentColorView.backgroundColor = self.value;
}

- (void)updateNewColor
{
    UISlider *s0 = self.sliders[0];
    UISlider *s1 = self.sliders[1];
    UISlider *s2 = self.sliders[2];
    UISlider *s3 = self.sliders[3];
    UIColor *color;
    switch (self.colorSpacePicker.selectedSegmentIndex) {
        case 0:
            color = [UIColor colorWithRed:s0.value
                                    green:s1.value
                                     blue:s2.value
                                    alpha:s3.value];
            break;
        case 1:
            color = [UIColor colorWithHue:s0.value
                               saturation:s1.value
                               brightness:s2.value
                                    alpha:s3.value];
            break;
        default:
            break;
    }
    self.updatedColorView.backgroundColor = color;
    self.value = self.updatedColorView.backgroundColor;
}

- (void)commitNewColor
{
    [self updateCurrentColor];
}

#pragma mark - Creating color picker configs

+ (TKColorPickerConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    UIColor *value = [target valueForKeyPath:keyPath];
    return [self configWithName:name changeHandler:^(id value) {
        [target setValue:value forKeyPath:keyPath];
    } value:value];
}

+ (TKColorPickerConfig *)configWithName:(NSString *)name changeHandler:(TKValueCallback)changeHandler value:(UIColor *)value
{
    TKColorPickerConfig *config = [[TKColorPickerConfig alloc] initWithName:name type:TKConfigTypeColorPicker];
    config.changeHandler = changeHandler;
    config.value = value;
    return config;
}

@end
