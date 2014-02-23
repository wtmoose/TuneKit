//
//  TKSliderConfig.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKSliderConfig : TKConfig

@property (nonatomic) float value;
@property (nonatomic) float minValue;
@property (nonatomic) float maxValue;
@property (copy, nonatomic) NSArray *validValues;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

+ (TKSliderConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;
+ (TKSliderConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(float)min max:(float)max;
+ (TKSliderConfig *)configWithName:(NSString *)name changeHandler:(TKValueCallback)changeHandler value:(float)value;
+ (TKSliderConfig *)configWithName:(NSString *)name changeHandler:(TKValueCallback)changeHandler value:(float)value min:(float)min max:(float)max;

@end