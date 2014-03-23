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
@property (strong, nonatomic) NSMutableDictionary *dataModelsByPath;
@property (strong, nonatomic) NSMutableArray *pathStack;
@property (strong, nonatomic) NSMutableArray *sectionNameStack;
@end

static TuneKit *sharedInstance = nil;
NSString *kTuneKitTopNode = @"kTuneKitTopNode";
NSString *kTuneKitPathRemovedNotification = @"kTuneKitPathRemovedNotification";
NSString *kTuneKitPathChangedNotification = @"kTuneKitPathChangedNotification";
NSString *kTuneKitDataModelKey = @"kTuneKitDataModelKey";
NSString *kTuneKitPathKey = @"kTuneKitPathKey";
NSString *kTuneKitNoSectionName = @"kTuneKitNoSectionName";
NSString *kTuneKitNavigationSectionName = @"kTuneKitNavigationSectionName";

@implementation TuneKit

+ (TuneKit *)sharedInstance
{
    return sharedInstance;
}

#pragma mark - Enabling TuneKit (public)

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

#pragma mark - Presenting the control panel (public)

+ (void)presentControlPanelAtLeftOrigin:(CGFloat)leftOrigin
{
    TuneKit *tk = [self sharedInstance];
    [tk presentControlPanelAtLeftOrigin:leftOrigin];
}

+ (void)dismissControlPanel
{
    TuneKit *tk = [self sharedInstance];
    [tk dismissControlPanel];
}

#pragma mark - Managing the configuration heirarchy (public)

+ (void)add:(TKCallback)add inPath:(NSArray *)path sectionName:(NSString *)sectionName
{
    TuneKit *tk = [self sharedInstance];
    [tk add:add inPath:path sectionName:sectionName];
}

+ (void)removePath:(NSArray *)path
{
    TuneKit *tk = [self sharedInstance];
    [tk removePath:path];
}

+ (NSArray *)pathForViewController:(UIViewController *)viewController
{
    return [self pathForViewController:viewController subpath:nil];
}

+ (NSArray *)pathForViewController:(UIViewController *)viewController subpath:(NSArray *)subpath
{
    if (viewController == nil) {
        return nil;
    }
    
    NSArray *parentPath = [self pathForViewController:viewController.parentViewController];
    NSMutableArray *path = [NSMutableArray arrayWithCapacity:[parentPath count] + 1];
    [path addObjectsFromArray:parentPath];
    NSString *pathElement = viewController.title;
    if (pathElement) {
        [path addObject:pathElement];
    }
    [path addObjectsFromArray:subpath];
    
    return path;
}

#pragma mark - Adding controls (public)


+ (TKButtonConfig *)addButton:(NSString *)name target:(id)target selector:(SEL)selector
{
    TuneKit *tk = [self sharedInstance];
    return [tk addButton:name target:target selector:selector];
}

+ (TKButtonConfig *)addButton:(NSString *)name actionHanlder:(TKCallback)actionHanlder
{
    TuneKit *tk = [self sharedInstance];
    return [tk addButton:name actionHanlder:actionHanlder];
}

+ (TKSliderConfig *)addSlider:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSlider:name target:target keyPath:keyPath min:min max:max];
}

+ (TKSwitchConfig *)addSwitch:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSwitch:name target:target keyPath:keyPath];
}

+ (TKColorPickerConfig *)addColorPicker:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TuneKit *tk = [self sharedInstance];
    return [tk addColorPicker:name target:target keyPath:keyPath];
}

+ (TKLabelConfig *)addLabel:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TuneKit *tk = [self sharedInstance];
    return [tk addLabel:name target:target keyPath:keyPath];
}

+ (TKRateConfig *)addRate:(NSString *)name target:(id)target keyPath:(NSString *)keyPath sampleInterval:(NSTimeInterval)sampleInterval
{
    TuneKit *tk = [self sharedInstance];
    return [tk addRate:name target:target keyPath:keyPath sampleInterval:sampleInterval];
}

#pragma mark - Presenting the control panel (private)

- (void)presentControlPanelAtLeftOrigin:(CGFloat)leftOrigin
{
    if (self.dialog == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TuneKit" bundle:nil];
        self.dialog = [storyboard instantiateViewControllerWithIdentifier:@"ControlPanelDialog"];
        TKControlPanelTableViewController *controlPanel = (TKControlPanelTableViewController *)[self.dialog.viewControllers firstObject];
        controlPanel.path = kTuneKitTopNode;
        controlPanel.nodeViewControllerProvider = [self newNodeViewControllerProvider:controlPanel];
        controlPanel.indexPathController.dataModel = [self.dataModelsByPath objectForKey:kTuneKitTopNode];
    }
    [self.dialog presentAtLeftOrigin:leftOrigin];
}

- (TKControlPanelTableViewController *(^)(NSString *))newNodeViewControllerProvider:(TKControlPanelTableViewController *)parentControlPanel
{
    __weak TuneKit *weakSelf = self;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TuneKit" bundle:nil];
    return ^TKControlPanelTableViewController *(NSString *nodeName) {
        NSString *path = [NSString stringWithFormat:@"%@ > %@", parentControlPanel.path, nodeName];
        TKControlPanelTableViewController *nodePanel = [storyboard instantiateViewControllerWithIdentifier:@"ControlPanel"];
        nodePanel.title = nodeName;
        nodePanel.path = path;
        nodePanel.nodeViewControllerProvider = [weakSelf newNodeViewControllerProvider:nodePanel];
        nodePanel.indexPathController.dataModel = [weakSelf.dataModelsByPath objectForKey:path];
        return nodePanel;
    };
}

- (void)dismissControlPanel
{
    [self.dialog dismiss];
}

#pragma mark - Managing the configuration heirarchy (private)

- (void)add:(TKCallback)add inPath:(NSArray *)path sectionName:(NSString *)sectionName
{
    if (sectionName == nil) {
        sectionName = kTuneKitNoSectionName;
    }
    
    NSMutableString *pathString = [[NSMutableString alloc] initWithString:kTuneKitTopNode];
    for (NSString *name in path) {
        [self.pathStack addObject:pathString];
        [self.sectionNameStack addObject:kTuneKitNavigationSectionName];
        [self addNavigationNode:name];
        [self.pathStack removeLastObject];
        [self.sectionNameStack removeLastObject];
        [pathString appendFormat:@" > %@", name];
    }
    if (add) {
        [self.pathStack addObject:pathString];
        [self.sectionNameStack addObject:sectionName];
        add();
        [self.pathStack removeLastObject];
        [self.sectionNameStack removeLastObject];
    }
}

- (void)removePath:(NSArray *)path
{
    NSMutableArray *tmpPath = [NSMutableArray arrayWithObject:kTuneKitTopNode];
    [tmpPath addObjectsFromArray:path];
    NSString *pathString = [tmpPath componentsJoinedByString:@" > "];
    NSString *node = [tmpPath lastObject];
    [tmpPath removeLastObject];
    NSString *parentPathString = [tmpPath componentsJoinedByString:@" > "];
    [self removeNode:node path:pathString fromParentPath:parentPathString];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTuneKitPathRemovedNotification object:self userInfo:@{kTuneKitPathKey : pathString}];
}

- (void)removeNode:(NSString *)node path:(NSString *)path fromParentPath:(NSString *)parentPath
{
    TLIndexPathDataModel *dataModel = [self.dataModelsByPath objectForKey:path];
    for (TLIndexPathItem *item in dataModel.items) {
        TKConfig *config = item.data;
        switch (config.type) {
            case TKConfigTypeNode:
            {
            NSString *childPath = [NSString stringWithFormat:@"%@ > %@", path, config.name];
            [self removeNode:config.name path:childPath fromParentPath:path];
            break;
            }
            default:
                break;
        }
    }
    // remove self after all children have bene removed
    [self removeIdentifier:node fromDataModelForPath:parentPath];
    [self.dataModelsByPath removeObjectForKey:path];
}

- (void)addConfigToDataModel:(TKConfig *)config
{
    NSString *path = [self.pathStack lastObject];
    NSString *sectionName = [self.sectionNameStack lastObject];
    if (!path) {
        path = kTuneKitTopNode;
        [self.pathStack addObject:path];
    }
    if (!sectionName) {
        sectionName = kTuneKitNoSectionName;
        [self.sectionNameStack addObject:sectionName];
    }
    TLIndexPathDataModel *oldDataModel = [self.dataModelsByPath objectForKey:path];
    NSMutableArray *items = [NSMutableArray arrayWithArray:oldDataModel.items];
    TLIndexPathItem *item = [[TLIndexPathItem alloc] initWithIdentifier:config.name sectionName:sectionName cellIdentifier:nil data:config];
    [items addObject:item];
    //    [items sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    //        NSString *string1 = [obj1 identifier];
    //        NSString *string2 = [obj2 identifier];
    //        return [string1 caseInsensitiveCompare:string2];
    //    }];
    TLIndexPathDataModel *dataModel = [[TLIndexPathDataModel alloc] initWithItems:items];
    [self.dataModelsByPath setObject:dataModel forKey:path];
    [self notifyPathChanged:path];
}

- (void)removeIdentifier:(id)identifier fromDataModelForPath:(NSString *)path
{
    //    NSLog(@"Removing %@ from data model at %@", identifier, path);
    TLIndexPathDataModel *oldDataModel = [self.dataModelsByPath objectForKey:path];
    id item = [oldDataModel itemForIdentifier:identifier];
    NSMutableArray *items = [NSMutableArray arrayWithArray:oldDataModel.items];
    [items removeObject:item];
    if ([items count]) {
        TLIndexPathDataModel *dataModel = [[TLIndexPathDataModel alloc] initWithItems:items];
        [self.dataModelsByPath setObject:dataModel forKey:path];
        //        NSLog(@"Update data model at %@", path);
    } else {
        [self.dataModelsByPath removeObjectForKey:path];
        //        NSLog(@"Removed empty data model at %@", path);
    }
    [self notifyPathChanged:path];
}

- (void)notifyPathChanged:(NSString *)path
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    userInfo[kTuneKitPathKey] = path;
    TLIndexPathDataModel *dataModel = [self.dataModelsByPath objectForKey:path];
    if (dataModel) {
        userInfo[kTuneKitDataModelKey] = dataModel;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kTuneKitPathChangedNotification object:self userInfo:userInfo];
}

- (NSMutableArray *)pathStack
{
    if (_pathStack == nil) {
        _pathStack = [NSMutableArray array];
    }
    return _pathStack;
}

- (NSMutableArray *)sectionNameStack
{
    if (_sectionNameStack == nil) {
        _sectionNameStack = [NSMutableArray array];
    }
    return _sectionNameStack;
}

- (NSMutableDictionary *)dataModelsByPath
{
    if (_dataModelsByPath == nil) {
        _dataModelsByPath = [NSMutableDictionary dictionary];
    }
    return _dataModelsByPath;
}

#pragma mark - Adding controls (private)

- (TKNodeConfig *)addNavigationNode:(NSString *)name
{
    TKNodeConfig *config = [TKNodeConfig configWithName:name];
    [self addConfigToDataModel:config];
    return config;
}

- (TKButtonConfig *)addButton:(NSString *)name target:(id)target selector:(SEL)selector
{
    TKButtonConfig *config = [TKButtonConfig configWithName:name target:target selector:selector];
    [self addConfigToDataModel:config];
    return config;
}

- (TKButtonConfig *)addButton:(NSString *)name actionHanlder:(TKCallback)actionHanlder
{
    TKButtonConfig *config = [TKButtonConfig configWithName:name actionHanlder:actionHanlder];
    [self addConfigToDataModel:config];
    return config;
}

- (TKSliderConfig *)addSlider:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    TKSliderConfig *config = [TKSliderConfig configWithName:name target:target keyPath:keyPath min:min max:max];
    [self addConfigToDataModel:config];
    return config;
}

- (TKSwitchConfig *)addSwitch:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TKSwitchConfig *config = [TKSwitchConfig configWithName:name target:target keyPath:keyPath];
    [self addConfigToDataModel:config];
    return config;
}

- (TKColorPickerConfig *)addColorPicker:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TKColorPickerConfig *config = [TKColorPickerConfig configWithName:name target:target keyPath:keyPath];
    [self addConfigToDataModel:config];
    return config;
}

- (TKLabelConfig *)addLabel:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TKLabelConfig *config = [TKLabelConfig configWithName:name target:target keyPath:keyPath];
    [self addConfigToDataModel:config];
    return config;
}

- (TKRateConfig *)addRate:(NSString *)name target:(id)target keyPath:(NSString *)keyPath sampleInterval:(NSTimeInterval)sampleInterval
{
    TKRateConfig *config = [TKRateConfig configWithName:name target:target keyPath:keyPath sampleInterval:sampleInterval];
    [self addConfigToDataModel:config];
    return config;
}

@end
