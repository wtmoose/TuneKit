//
//  TuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGlobal.h"
#import "TKButtonConfig.h"
#import "TKSliderConfig.h"
#import "TKColorPickerConfig.h"

@interface TuneKit : NSObject

#pragma mark - Configuration

/**
 Enables TuneKit. None of the methods in this class do anything until this method
 */
+ (void)enable;

/**
 Returns YES if TuneKit is enabled.
 */
+ (BOOL)isEnabled;

/**
 */
+ (TKButtonConfig *)addButton:(id)path target:(id)target selector:(SEL)selector;

/**
 */
+ (TKButtonConfig *)addButton:(id)path actionHanlder:(TKCallback)actionHanlder;

/**
 */
+ (TKSliderConfig *)addSlider:(id)path target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max;

/**
 */
+ (TKColorPickerConfig *)addColorPicker:(id)path target:(id)target keyPath:(NSString *)keyPath;

/**
 */
+ (void)removePath:(id)path;

#pragma mark - Presenting control panels

+ (void)presentControlPanel;

+ (void)dismissControlPanel;

@end
