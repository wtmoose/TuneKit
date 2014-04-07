//
//  TuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

// TODO add an option to use KVO

#import <UIKit/UIKit.h>
#import "TKGlobal.h"
#import "TKNodeConfig.h"
#import "TKButtonConfig.h"
#import "TKSwitchConfig.h"
#import "TKSliderConfig.h"
#import "TKSegmentedControlConfig.h"
#import "TKPickerViewConfig.h"
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

/**
 */
extern NSString *kTuneKitNoSectionName;

/**
 */
extern NSString *kTuneKitNavigationSectionName;

@interface TuneKit : NSObject

#pragma mark - Enabling TuneKit

/**
 Enables TuneKit. None of the methods in this class do 
 anything until TuneKit is enabled.
 */
+ (void)enable;

/**
 Returns YES if TuneKit is enabled.
 */
+ (BOOL)isEnabled;

#pragma mark - Presenting the control panel

+ (void)presentControlPanelAtLeftOrigin:(CGFloat)leftOrigin;

+ (void)dismissControlPanel;

#pragma mark - Managing the configuration heirarchy

/**
 Organizes the configuration based on the given path and section name.
 
 The TuneKit control panel is organized into a heirarchichy. The `path`
 argument defines the location in this heirarchy of any controls added within
 the `add` block. The heirarchy is displayed in a standard drill-down table
 view interface. Controls can be further organized into sections by the
 given `sectionName`.
 
 A typical approach to organizing control panel content is to mirror the
 view controller containment heirarchy, having individual view controllers
 add content in `viewWillAppear` and remove content by calling `removePath`
 in `viewWillDisappear`.
 
 As a convenience, the `pathForViewController:` method returns a path array
 containing the titles of the given view controller and its ancestors. Note 
 that `pathForViewController:` is not recommended for view controllers that have
 dynamic titles because subsequent calls to `pathForViewController:` may return
 a different path.
 */
+ (void)add:(TKCallback)add inPath:(NSArray *)path sectionName:(NSString *)sectionName;

/**
 Returns an array of strings containing the titles of the given view controller
 and its ancestors. Any view controller that doesn't have a title set is skipped.
 */
+ (NSArray *)pathForViewController:(UIViewController *)viewController;

/**
 Returns an array of strings containing the titles of the given view controller
 and its ancestors, suffixed with an optional subpath. Any view controller that
 doesn't have a title set is skipped.
 */
+ (NSArray *)pathForViewController:(UIViewController *)viewController
                           subpath:(NSArray *)subpath;

/**
 Remove the specified path and all of it's content.
 */
+ (void)removePath:(NSArray *)path;

#pragma mark - Adding controls

/**
 */
+ (TKButtonConfig *)addButton:(NSString *)name target:(id)target
                     selector:(SEL)selector;

/**
 */
+ (TKButtonConfig *)addButton:(NSString *)name
                actionHanlder:(TKCallback)actionHanlder;

/**
 */
+ (TKSwitchConfig *)addSwitch:(NSString *)name target:(id)target
                      keyPath:(NSString *)keyPath;

/**
 */
+ (TKSliderConfig *)addSlider:(NSString *)name target:(id)target
                      keyPath:(NSString *)keyPath min:(CGFloat)min
                          max:(CGFloat)max;

/**
 */
+ (TKSegmentedControlConfig *)addSegmentedControl:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     segmentNames:(NSArray *)segmentNames;

/**
 */
+ (TKSegmentedControlConfig *)addSegmentedControl:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     segmentNames:(NSArray *)segmentNames
                                    segmentValues:(NSArray *)segmentValues;

/**
 */
+ (TKPickerViewConfig *)addPickerView:(NSString *)name
                               target:(id)target
                              keyPath:(NSString *)keyPath
                          pickerNames:(NSArray *)pickerNames;

/**
 */
+ (TKPickerViewConfig *)addPickerView:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     pickerNames:(NSArray *)pickerNames
                                    pickerValues:(NSArray *)pickerValues;

/**
 */
+ (TKColorPickerConfig *)addColorPicker:(NSString *)name target:(id)target
                                keyPath:(NSString *)keyPath;

/**
 Displays the given key path as a label
 */
+ (TKLabelConfig *)addLabel:(NSString *)name target:(id)target
                    keyPath:(NSString *)keyPath;

/**
 Displays the rate at which the given key path is changed.
 */
+ (TKRateConfig *)addRate:(NSString *)name target:(id)target
                  keyPath:(NSString *)keyPath
           sampleInterval:(NSTimeInterval)sampleInterval;

#pragma mark - Default values

/**
 */

+ (id)defaultValueForIdentifier:(NSString *)identifier
                   defaultGroup:(NSString *)defaultGroup;

+ (void)setDefaultValue:(id)value forIdentifier:(NSString *)identifier
           defaultGroup:(NSString *)defaultGroup;

+ (void)removeDefaultValueForIdentifier:(NSString *)identifier
                           defaultGroup:(NSString *)defaultGroup;

@end

/**
 */
NSString *TKPluginName(NSString *prefix, NSString *suffix);

/**
 Import extensions
 */

#import "UIView+TuneKit.h"
#import "UIViewAnimator.h"
#import "UIViewSpringAnimator.h"
#import "CAAnimator.h"
#import "CABasicAnimator.h"
#import "CAGroupAnimator.h"
#import "CATransitionAnimator.h"
#import "CAKeyFrameAnimator.h"


