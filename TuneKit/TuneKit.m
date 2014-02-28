//
//  TuneKit.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TuneKit.h"
#import <TLIndexPathTools/TLIndexPathItem.h>
#import "TKDialogViewController.h"
#import "TKControlPanelTableViewController.h"

@interface TuneKit ()
@property (strong, nonatomic) TKDialogViewController *dialog;
@property (strong, nonatomic) TKControlPanelTableViewController *controlPanel;
@end

static TuneKit *sharedInstance = nil;

@implementation TuneKit

+ (TuneKit *)sharedInstance
{
    return sharedInstance;
}

#pragma mark - Configuration

+ (void)enable
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TuneKit alloc] init];
    });
}

+ (BOOL)isEnabled
{
    return [self sharedInstance] != nil;
}

+ (TKButtonConfig *)addButton:(id)path target:(id)target selector:(SEL)selector
{
    TuneKit *tk = [self sharedInstance];
    return [tk addButton:path target:target selector:selector];
}

- (TKButtonConfig *)addButton:(id)path target:(id)target selector:(SEL)selector
{
    NSString *name = [self nameFromPath:path];
    TKButtonConfig *config = [TKButtonConfig configWithName:name target:target selector:selector];
    [self addConfig:config path:path];
    return config;
}

+ (TKButtonConfig *)addButton:(id)path actionHanlder:(TKCallback)actionHanlder
{
    TuneKit *tk = [self sharedInstance];
    return [tk addButton:path actionHanlder:actionHanlder];
}

- (TKButtonConfig *)addButton:(id)path actionHanlder:(TKCallback)actionHanlder
{
    NSString *name = [self nameFromPath:path];
    TKButtonConfig *config = [TKButtonConfig configWithName:name actionHanlder:actionHanlder];
    [self addConfig:config path:path];
    return config;
}

+ (TKSliderConfig *)addSlider:(id)path target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSlider:path target:target keyPath:keyPath min:min max:max];
}

- (TKSliderConfig *)addSlider:(id)path target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    NSString *name = [self nameFromPath:path];
    TKSliderConfig *config = [TKSliderConfig configWithName:name target:target keyPath:keyPath min:min max:max];
    [self addConfig:config path:path];
    return config;
}

+ (TKColorPickerConfig *)addColorPicker:(id)path target:(id)target keyPath:(NSString *)keyPath
{
    TuneKit *tk = [self sharedInstance];
    return [tk addColorPicker:path target:target keyPath:keyPath];
}

- (TKColorPickerConfig *)addColorPicker:(id)path target:(id)target keyPath:(NSString *)keyPath
{
    NSString *name = [self nameFromPath:path];
    TKColorPickerConfig *config = [TKColorPickerConfig configWithName:name target:target keyPath:keyPath];
    [self addConfig:config path:path];
    return config;
}

- (void)addConfig:(TKConfig *)config path:(id)path
{
    //TODO Support panel organized by paths
    NSMutableArray *items = [NSMutableArray arrayWithArray:self.controlPanel.indexPathController.items];
    NSString *identifier = [self pathStringFromPath:path];
    TLIndexPathItem *item = [[TLIndexPathItem alloc] initWithIdentifier:identifier
                                                            sectionName:nil
                                                         cellIdentifier:nil
                                                                   data:config];
    [items addObject:item];
    self.controlPanel.indexPathController.items = items;
}

+ (void)removePath:(id)path
{
    TuneKit *tk = [self sharedInstance];
    [tk removePath:path];
}

- (void)removePath:(id)path
{
    //TODO This currently only works with leaf paths
    NSString *identifier = [self pathStringFromPath:path];
    id item = [self.controlPanel.indexPathController.dataModel itemForIdentifier:identifier];
    if (item) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:self.controlPanel.indexPathController.items];
        [items removeObject:item];
        self.controlPanel.indexPathController.items = items;
    }
}

- (NSString *)nameFromPath:(id)path
{
    if ([path isKindOfClass:[NSString class]]) {
        return path;
    } else if ([path isKindOfClass:[NSArray class]]) {
        return [path lastObject];
    } else {
        [NSException raise:@"InvalidArgument" format:@"Path '%@' must be an NSString or NSArray of NSStrings", path];
    }
    return nil;
}

- (NSString *)pathStringFromPath:(id)path
{
    if ([path isKindOfClass:[NSString class]]) {
        return path;
    } else if ([path isKindOfClass:[NSArray class]]) {
        return [path componentsJoinedByString:@"."];
    } else {
        [NSException raise:@"InvalidArgument" format:@"Path '%@' must be an NSString or NSArray of NSStrings", path];
    }
    return nil;
}

#pragma mark - Presenting control panels

- (TKDialogViewController *)dialog
{
    if (!_dialog) {
        self.dialog = [[TKDialogViewController alloc] initWithNibName:@"TKDialog" bundle:nil];
        self.dialog.contentViewController = self.controlPanel;
    }
    return _dialog;
}

- (TKControlPanelTableViewController *)controlPanel
{
    if (!_controlPanel) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TuneKit" bundle:nil];
        _controlPanel = [storyboard instantiateViewControllerWithIdentifier:@"ControlPanel"];
    }
    return _controlPanel;
}

+ (void)presentControlPanel
{
    TuneKit *tk = [self sharedInstance];
    [tk presentControlPanel];
}

- (void)presentControlPanel
{
    self.dialog.contentViewController = self.controlPanel;
    [self.dialog present];
}

+ (void)dismissControlPanel
{
    TuneKit *tk = [self sharedInstance];
    [tk dismissControlPanel];
}

- (void)dismissControlPanel
{
    //TODO
}

@end
