//
//  TuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGlobal.h"
#import "TKNodeConfig.h"
#import "TKButtonConfig.h"
#import "TKSliderConfig.h"
#import "TKSwitchConfig.h"
#import "TKColorPickerConfig.h"
#import "TKLabelConfig.h"
#import "TKRateConfig.h"

/**
 */
extern NSString *kTuneKitPathRemovedNotification;

/**
 */
extern NSString *kTuneKitPathChangedNotification;

/**
 */
extern NSString *kTuneKitDataModelKey;

/**
 */
extern NSString *kTuneKitPathKey;

@interface TuneKit : NSObject

#pragma mark - Configuration

/**
 Enables TuneKit. None of the methods in this class do 
 anything until TuneKit is enabled.
 */
+ (void)enable;

/**
 Returns YES if TuneKit is enabled.
 */
+ (BOOL)isEnabled;

/**
 */
+ (void)add:(TKCallback)add inPath:(NSArray *)path;

/**
 Remove the specified path and all of it's content.
 */
+ (void)removePath:(NSArray *)path;

/**
 */
+ (TKButtonConfig *)addButton:(NSString *)name target:(id)target selector:(SEL)selector;

/**
 */
+ (TKButtonConfig *)addButton:(NSString *)name actionHanlder:(TKCallback)actionHanlder;

/**
 */
+ (TKSliderConfig *)addSlider:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max;

/**
 */
+ (TKSwitchConfig *)addSwitch:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

/**
 */
+ (TKColorPickerConfig *)addColorPicker:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

/**
 */
+ (TKLabelConfig *)addLabel:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

/**
 */
+ (TKRateConfig *)addRate:(NSString *)name target:(id)target keyPath:(NSString *)keyPath sampleInterval:(NSTimeInterval)sampleInterval;

#pragma mark - Presenting control panels

+ (void)presentControlPanelAtLeftOrigin:(CGFloat)leftOrigin;

+ (void)dismissControlPanel;

@end
