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

+ (TKSwitchConfig *)addSwitch:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSwitch:name target:target keyPath:keyPath];
}

+ (TKSliderConfig *)addSlider:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSlider:name target:target keyPath:keyPath min:min max:max];
}

+ (TKSegmentedControlConfig *)addSegmentedControl:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     segmentNames:(NSArray *)segmentNames
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSegmentedControl:name target:target keyPath:keyPath
                      segmentNames:segmentNames];
}

+ (TKSegmentedControlConfig *)addSegmentedControl:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     segmentNames:(NSArray *)segmentNames
                                    segmentValues:(NSArray *)segmentValues
{
    TuneKit *tk = [self sharedInstance];
    return [tk addSegmentedControl:name target:target keyPath:keyPath
                      segmentNames:segmentNames segmentValues:segmentValues];
}

+ (TKPickerViewConfig *)addPickerView:(NSString *)name
                               target:(id)target
                              keyPath:(NSString *)keyPath
                          pickerNames:(NSArray *)pickerNames
{
    TuneKit *tk = [self sharedInstance];
    return [tk addPickerView:name target:target keyPath:keyPath pickerNames:pickerNames];
}

+ (TKPickerViewConfig *)addPickerView:(NSString *)name
                               target:(id)target
                              keyPath:(NSString *)keyPath
                          pickerNames:(NSArray *)pickerNames
                         pickerValues:(NSArray *)pickerValues
{
    TuneKit *tk = [self sharedInstance];
    return [tk addPickerView:name target:target keyPath:keyPath pickerNames:pickerNames
                pickerValues:pickerValues];
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

#pragma mark - Default values (public)

+ (id)defaultValueForIdentifier:(NSString *)identifier defaultGroup:(NSString *)defaultGroup
{
    NSString *key = [self keyForIdentifier:identifier defaultGroup:defaultGroup];
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setDefaultValue:(id)value forIdentifier:(NSString *)identifier defaultGroup:(NSString *)defaultGroup
{
    NSString *key = [self keyForIdentifier:identifier defaultGroup:defaultGroup];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    if (value) {
//        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
//    } else {
//        [self removeDefaultValueForIdentifier:identifier defaultGroup:defaultGroup];
//    }
}

+ (void)removeDefaultValueForIdentifier:(NSString *)identifier defaultGroup:(NSString *)defaultGroup
{
    NSString *key = [self keyForIdentifier:identifier defaultGroup:defaultGroup];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

+ (NSString *)keyForIdentifier:(NSString *)identifier defaultGroup:(NSString *)defaultGroup
{
    return [NSString stringWithFormat:@"%@:%@", defaultGroup, identifier];
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
    __weak TKControlPanelTableViewController *weakParentControlPanel = parentControlPanel;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TuneKit" bundle:nil];
    return ^TKControlPanelTableViewController *(NSString *nodeName) {
        __strong TuneKit *strongSelf = weakSelf;
        __strong TKControlPanelTableViewController *strongParentControlPanel = weakParentControlPanel;
        NSString *path = [NSString stringWithFormat:@"%@/%@", strongParentControlPanel.path, nodeName];
        TKControlPanelTableViewController *nodePanel = [storyboard instantiateViewControllerWithIdentifier:@"ControlPanel"];
        nodePanel.title = nodeName;
        nodePanel.path = path;
        nodePanel.nodeViewControllerProvider = [strongSelf newNodeViewControllerProvider:nodePanel];
        nodePanel.indexPathController.dataModel = [strongSelf.dataModelsByPath objectForKey:path];
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
        [pathString appendFormat:@"/%@", name];
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
    NSString *pathString = [tmpPath componentsJoinedByString:@"/"];
    NSString *node = [tmpPath lastObject];
    [tmpPath removeLastObject];
    NSString *parentPathString = [tmpPath componentsJoinedByString:@"/"];
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
                NSString *childPath = [NSString stringWithFormat:@"%@/%@", path, config.name];
                [self removeNode:config.name path:childPath fromParentPath:path];
                break;
            }
            default:
                break;
        }
    }
    // remove self after all children have bene removed
    NSString *identifier = [NSString stringWithFormat:@"%@/%@/%@", parentPath, kTuneKitNavigationSectionName, node];
    [self removeIdentifier:identifier fromDataModelForPath:parentPath];
    [self.dataModelsByPath removeObjectForKey:path];
}

- (void)addConfigToDataModel:(TKConfig *)config
{
    NSString *path = [self.pathStack lastObject];
    NSString *sectionName = [self.sectionNameStack lastObject];
    TLIndexPathDataModel *oldDataModel = [self.dataModelsByPath objectForKey:path];
    NSMutableArray *items = [NSMutableArray arrayWithArray:oldDataModel.items];
    // TODO It might be confusing to use config.name as the identifier since config has
    // an identifier property. But name works because names must be unique for the given
    // data model. If this is changed to config.identifier, need to update places that
    // do stuff like [dataModel itemForIdentifier:].
    TLIndexPathItem *item = [[TLIndexPathItem alloc] initWithIdentifier:config.identifier sectionName:sectionName cellIdentifier:nil data:config];
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
        [_pathStack addObject:kTuneKitTopNode];
    }
    return _pathStack;
}

- (NSMutableArray *)sectionNameStack
{
    if (_sectionNameStack == nil) {
        _sectionNameStack = [NSMutableArray array];
        [_sectionNameStack addObject:kTuneKitNoSectionName];
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
    NSString *identifier = [self identifierForName:name];
    TKNodeConfig *config = [TKNodeConfig configWithName:name identifier:identifier];
    [self addConfigToDataModel:config];
    return config;
}

- (TKButtonConfig *)addButton:(NSString *)name target:(id)target selector:(SEL)selector
{
    NSString *identifier = [self identifierForName:name];
    TKButtonConfig *config = [TKButtonConfig configWithName:name identifier:identifier target:target selector:selector];
    [self addConfigToDataModel:config];
    return config;
}

- (TKButtonConfig *)addButton:(NSString *)name actionHanlder:(TKCallback)actionHanlder
{
    NSString *identifier = [self identifierForName:name];
    TKButtonConfig *config = [TKButtonConfig configWithName:name identifier:identifier actionHanlder:actionHanlder];
    [self addConfigToDataModel:config];
    return config;
}

- (TKSwitchConfig *)addSwitch:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    NSString *identifier = [self identifierForName:name];
    TKSwitchConfig *config = [TKSwitchConfig configWithName:name identifier:identifier target:target keyPath:keyPath];
    [self addConfigToDataModel:config];
    return config;
}

- (TKSliderConfig *)addSlider:(NSString *)name target:(id)target keyPath:(NSString *)keyPath min:(CGFloat)min max:(CGFloat)max
{
    NSString *identifier = [self identifierForName:name];
    TKSliderConfig *config = [TKSliderConfig configWithName:name identifier:identifier target:target keyPath:keyPath min:min max:max];
    [self addConfigToDataModel:config];
    return config;
}

- (TKSegmentedControlConfig *)addSegmentedControl:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     segmentNames:(NSArray *)segmentNames
{
    NSString *identifier = [self identifierForName:name];
    TKSegmentedControlConfig *config = [TKSegmentedControlConfig configWithName:name identifier:identifier target:target keyPath:keyPath segmentNames:segmentNames];
    [self addConfigToDataModel:config];
    return config;
}

- (TKSegmentedControlConfig *)addSegmentedControl:(NSString *)name
                                           target:(id)target
                                          keyPath:(NSString *)keyPath
                                     segmentNames:(NSArray *)segmentNames
                                    segmentValues:(NSArray *)segmentValues
{
    NSString *identifier = [self identifierForName:name];
    TKSegmentedControlConfig *config = [TKSegmentedControlConfig configWithName:name identifier:identifier target:target keyPath:keyPath segmentNames:segmentNames segmentValues:segmentValues];
    [self addConfigToDataModel:config];
    return config;
}

- (TKPickerViewConfig *)addPickerView:(NSString *)name
                               target:(id)target
                              keyPath:(NSString *)keyPath
                          pickerNames:(NSArray *)pickerNames
{
    NSString *identifier = [self identifierForName:name];
    TKPickerViewConfig *config = [TKPickerViewConfig configWithName:name
                                                         identifier:identifier
                                                             target:target
                                                            keyPath:keyPath
                                                        pickerNames:pickerNames];
    [self addConfigToDataModel:config];
    return config;
}

- (TKPickerViewConfig *)addPickerView:(NSString *)name
                               target:(id)target
                              keyPath:(NSString *)keyPath
                          pickerNames:(NSArray *)pickerNames
                         pickerValues:(NSArray *)pickerValues
{
    NSString *identifier = [self identifierForName:name];
    TKPickerViewConfig *config = [TKPickerViewConfig configWithName:name identifier:identifier target:target keyPath:keyPath pickerNames:pickerNames pickerValues:pickerValues];
    [self addConfigToDataModel:config];
    return config;
}

- (TKColorPickerConfig *)addColorPicker:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    NSString *identifier = [self identifierForName:name];
    TKColorPickerConfig *config = [TKColorPickerConfig configWithName:name identifier:identifier target:target keyPath:keyPath];
    [self addConfigToDataModel:config];
    return config;
}

- (TKLabelConfig *)addLabel:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    NSString *identifier = [self identifierForName:name];
    TKLabelConfig *config = [TKLabelConfig configWithName:name identifier:identifier target:target keyPath:keyPath];
    [self addConfigToDataModel:config];
    return config;
}

- (TKRateConfig *)addRate:(NSString *)name target:(id)target keyPath:(NSString *)keyPath sampleInterval:(NSTimeInterval)sampleInterval
{
    NSString *identifier = [self identifierForName:name];
    TKRateConfig *config = [TKRateConfig configWithName:name identifier:identifier target:target keyPath:keyPath sampleInterval:sampleInterval];
    [self addConfigToDataModel:config];
    return config;
}

- (NSString *)identifierForName:(NSString *)name
{
    NSString *path = [self.pathStack lastObject];
    NSString *sectionName = [self.sectionNameStack lastObject];
    if ([sectionName isEqualToString:kTuneKitNoSectionName]) {
        sectionName = nil;
    }
    return [NSString stringWithFormat:@"%@/%@/%@", path, sectionName, name];
}

@end

NSString *TKPluginName(NSString *prefix, NSString *suffix) {
    NSMutableArray *components = [NSMutableArray arrayWithCapacity:2];
    if (prefix) {
        [components addObject:prefix];
    }if (suffix) {
        [components addObject:suffix];
    }
    return [components componentsJoinedByString:@" "];
}

