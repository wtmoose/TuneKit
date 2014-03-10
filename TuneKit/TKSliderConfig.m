//
//  TKSliderConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKSliderConfig.h"
#import "TKGlobal.h"

@interface TKSliderConfig ()
@property (strong, nonatomic) TKValueCallback changeHandler;
@end

@implementation TKSliderConfig

#pragma mark - Model bindings

- (void)setValue:(float)value
{
    if (_value != value) {
        _value = value;
        [self updateValueViews];
        if (self.changeHandler) {
            self.changeHandler(@(value));
        }
    }
}

- (void)setMin:(float)min
{
    if (_min != min) {
        _min = min;
        [self updateSliderRange];
    }
}

- (void)setMax:(float)max
{
    if (_max != max) {
        _max = max;
        [self updateSliderRange];
    }
}

#pragma mark - View bindings

- (void)setSlider:(UISlider *)slider
{
    if (_slider != slider) {
        _slider = slider;
        [self updateSliderRange];
        [self updateValueViews];
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = [self.name uppercaseString];
    }
}

- (void)setValueLabel:(UILabel *)valueLabel
{
    if (_valueLabel != valueLabel) {
        _valueLabel = valueLabel;
        [self updateValueViews];
    }
}

#pragma mark - Slider

- (void)sliderValueChanged:(UISlider *)slider
{
    self.value = slider.value;
}

- (void)updateSliderRange
{
    self.slider.minimumValue = self.min;
    self.slider.maximumValue = self.max;
    self.value = MAX(self.min, self.value);
    self.value = MIN(self.max, self.value);
}

- (void)updateValueViews
{
    [self.slider setValue:self.value animated:YES];
    
    //TODO use a formula for this
    NSString *format = @"%0.0f";
    if (fabs(self.value) < .1f) {
        format = @"%0.4f";
    } else if (fabs(self.value) < 1.f) {
        format = @"%0.3f";
    } else if (fabs(self.value) < 100.f) {
        format = @"%0.2f";
    } else if (fabs(self.value) < 1000.f) {
        format = @"%0.1f";
    }
    self.valueLabel.text = [NSString stringWithFormat:format, self.value];
}

#pragma mark - Creating slider configs

+ (TKSliderConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    NSNumber *value = [target valueForKeyPath:keyPath];
    __weak id weakTarget = target;
    return [self configWithName:name changeHandler:^(id value) {
        [weakTarget setValue:value forKeyPath:keyPath];
    } value:[value floatValue] min:min max:max];
}

+ (TKSliderConfig *)configWithName:(NSString *)name changeHandler:(TKValueCallback)changeHandler value:(float)value min:(CGFloat)min max:(CGFloat)max
{
    TKSliderConfig *config = [[TKSliderConfig alloc] initWithName:name type:TKConfigTypeSlider];
    config.changeHandler = changeHandler;
    config.max = max;
    config.min = min;
    config.value = value;
    return config;
}

@end
