//
//  TKSliderConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKSliderConfig.h"
#import "TKGlobal.h"
#import "NSObject+Utils.h"

@interface TKSliderConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@end

@implementation TKSliderConfig

//- (void)dealloc
//{
//    if (self.target) {
//        [self.target removeObserver:self forKeyPath:self.keyPath];
//    }
//}

#pragma mark - Model bindings

- (void)setValue:(float)value
{
    if (_value != value) {
        [self setValueInternal:value];
        if (self.target) {
            [self.target setValue:@(value) forKeyPath:self.keyPath];
        }
    }
}

- (void)setValueInternal:(float)value
{
    _value = value;
    [self updateValueViews];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    float value = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
    if (self.value != value) {
        [self setValueInternal:value];
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

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath min:(float)min max:(float)max
{
    if (self = [super initWithName:name type:type identifier:identifier]) {
        _target = target;
        _keyPath = keyPath;
        _min = min;
        _max = max;
        float value = [[target valueForKeyPath:keyPath] floatValue];
        [self setValueInternal:value];
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

+ (TKSliderConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    TKSliderConfig *config = [[TKSliderConfig alloc] initWithName:name type:TKConfigTypeSlider identifier:identifier target:target keyPath:keyPath min:min max:max];
    return config;
}

@end
