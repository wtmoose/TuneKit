//
//  TKColorPickerConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

//TODO Handle non-RBG initial color values

#import "TKColorPickerConfig.h"
#import "TKGlobal.h"
#import "NSObject+Utils.h"
#import "TuneKit.h"

@interface TKColorPickerConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@property (nonatomic) UIColor *initialValue;
@end

@implementation TKColorPickerConfig

//- (void)dealloc
//{
//    if (self.target) {
//        [self.target removeObserver:self forKeyPath:self.keyPath];
//    }
//}

#pragma mark - Model bindings

- (void)setValue:(UIColor *)value
{
    if (![NSObject nilSafeObject:_value isEqual:value]) {
        [self setValueInternal:value];
        if (self.target) {
            [self.target setValue:value forKeyPath:self.keyPath];
        }
    }
}

- (void)setValueInternal:(UIColor *)value
{
    _value = value;
    if (self.defaultGroupName) {
        NSData *valueData = [NSKeyedArchiver archivedDataWithRootObject:value];
        [TuneKit setDefaultValue:valueData forIdentifier:self.identifier defaultGroup:self.defaultGroupName];
    }
    [self updateValueViews];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    UIColor *value = [change objectForKey:NSKeyValueChangeNewKey];
//    if (![NSObject nilSafeObject:self.value isEqual:value]) {
//        [self setValueInternal:value];
//        [self updateNewColor];
//        [self commitNewColor];
//    }
//}

#pragma mark - View bindings

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = [self.name uppercaseString];
    }
}

- (void)setColorSpacePicker:(UISegmentedControl *)colorSpacePicker
{
    _colorSpacePicker = colorSpacePicker;
    [colorSpacePicker addTarget:self action:@selector(updateValueViews) forControlEvents:UIControlEventValueChanged];
}

- (void)setSliderLabels:(NSArray *)sliderLabels
{
    _sliderLabels = sliderLabels;
    [self updateValueViews];
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
    [self updateValueViews];
}

- (void)setSliderValues:(NSArray *)sliderValues
{
    _sliderValues = sliderValues;
    [self updateValueViews];
}

- (void)setCurrentColorView:(UIView *)currentColorView
{
    _currentColorView = currentColorView;
    [self updateCurrentColor];
}

- (void)setUpdatedColorView:(UIView *)newColorView
{
    _updatedColorView = newColorView;
    [self updateNewColorWithSliders];
}

#pragma mark - Sliders

- (void)sliderValueChanged:(UISlider *)slider
{
    [self updateNewColorWithSliders];
}

- (void)sliderValueStoppedChanging:(UISlider *)slider
{
    [self commitNewColor];
}

- (void)updateValueViews
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
    
    self.hexTextField.text = [[self hexForColor:self.value] uppercaseString];
}
                              
-(NSString *)hexForColor:(UIColor *)uiColor{
    CGFloat red, green, blue, alpha;
    [uiColor getRed:&red green:&green blue:&blue alpha:&alpha];
    red = roundf(red*255.f);
    green = roundf(green*255.f);
    blue = roundf(blue*255.f);
    alpha = roundf(alpha*255.f);
    NSString *hexString = [NSString stringWithFormat:@"#%02x%02x%02x%02x",
                            ((int)red),((int)green),((int)blue), ((int)alpha)];
    return hexString;
}

#pragma mark - Colors

- (void)updateCurrentColor
{
    self.currentColorView.backgroundColor = self.value;
}

- (void)updateNewColor
{
    self.updatedColorView.backgroundColor = self.value;
}

- (void)updateNewColorWithSliders
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

#pragma mark - Default values

- (void)setDefaultGroupName:(NSString *)defaultGroup
{
    if (![NSObject nilSafeObject:self.defaultGroupName isEqual:defaultGroup]) {
        super.defaultGroupName = defaultGroup;
        
        if (defaultGroup) {
            NSData *defaultValueData = [TuneKit defaultValueForIdentifier:self.identifier defaultGroup:defaultGroup];
            
            if (defaultValueData) {
                self.value = [NSKeyedUnarchiver unarchiveObjectWithData:defaultValueData];
            } else {
                NSData *defaultValueData = [NSKeyedArchiver archivedDataWithRootObject:self.value];
                [TuneKit setDefaultValue:defaultValueData forIdentifier:self.identifier defaultGroup:defaultGroup];
            }
        } else {
            self.value = self.initialValue;
        }
    }
}

#pragma mark - Creating color picker configs

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    if (self = [super initWithName:name type:type identifier:identifier]) {
        _target = target;
        _keyPath = keyPath;
        self.initialValue = [target valueForKeyPath:keyPath];
        [self setValueInternal:self.initialValue];
//        [target addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

+ (TKColorPickerConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    TKColorPickerConfig *config = [[TKColorPickerConfig alloc] initWithName:name type:TKConfigTypeColorPicker identifier:identifier target:target keyPath:keyPath];
    return config;
}

+ (UIColor *)rgbColorForColor:(UIColor *)color
{
    if (![color getRed:NULL green:NULL blue:NULL alpha:NULL]) {
        CGFloat white, alpha;
        [color getWhite:&white alpha:&alpha];
        return [UIColor colorWithRed:white green:white blue:white alpha:alpha];
    }
    return color;
}

@end
