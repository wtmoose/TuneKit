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
@property (nonatomic) float min;
@property (nonatomic) float max;

#pragma mark - View bindings

@property (weak, nonatomic) UISlider *slider;
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UILabel *valueLabel;

#pragma mark - Creating slider configs

+ (instancetype)configWithName:(NSString *)name
                        identifier:(NSString *)identifier
                            target:(id)target
                           keyPath:(NSString *)keyPath
                               min:(CGFloat)min
                               max:(CGFloat)max;

@end
