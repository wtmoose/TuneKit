//
//  TKTableViewController.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKControlPanelTableViewController.h"
#import <TLIndexPathTools/TLIndexPathItem.h>
#import "TuneKit.h"
#import "NSObject+Utils.h"

static  NSString *kTKDefaultGroupNumberChangedNotification = @"kTKDefaultGroupNumberChangedNotification";

static  NSString *kTKDefaultGroupNumberKey = @"kTKDefaultGroupNumberKey";

@interface TKControlPanelTableViewController ()
@property (weak, nonatomic) UISegmentedControl *defaultGroupSelector;
@property (nonatomic) NSInteger defaultGroupIndex;
@property (readonly, strong, nonatomic) NSString *defaultGroupName;
@end

@implementation TKControlPanelTableViewController

#pragma mark - View controller lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _defaultGroupIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self installToolbar];

    if (self.defaultGroupIndex == -1) {
        self.defaultGroupIndex = 1;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pathChanged:)
                                                 name:kTuneKitPathChangedNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pathRemoved:)
                                                 name:kTuneKitPathRemovedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(observeDefaultGroupChanged:)
                                                 name:kTKDefaultGroupNumberChangedNotification
                                               object:nil];
}

- (void)installToolbar
{
    UISegmentedControl *defaultGroupSelector = [[UISegmentedControl alloc] initWithItems:@[@"Original", @"Tuned"]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:defaultGroupSelector];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = @[leftSpace, item, rightSpace];
    [defaultGroupSelector addTarget:self action:@selector(defaultGroupChanged:) forControlEvents:UIControlEventValueChanged];
    self.defaultGroupSelector = defaultGroupSelector;
    self.defaultGroupSelector.selectedSegmentIndex = self.defaultGroupIndex;
}

- (IBAction)dismiss
{
    [TuneKit dismissControlPanel];
}

#pragma mark - Configuration

- (void)pathChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *path = [userInfo valueForKey:kTuneKitPathKey];
    if ([self.path isEqualToString:path]) {
        TLIndexPathDataModel *dataModel = [userInfo valueForKey:kTuneKitDataModelKey];
        self.indexPathController.dataModel = dataModel;
    }
}

- (void)pathRemoved:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *path = [userInfo valueForKey:kTuneKitPathKey];
    if ([self.path isEqualToString:path]) {
        // proactively discard indexPathController because, otherwise, there may
        // be timing issues with deallocating controls that are KVO'ing client properties
        self.indexPathController = nil;
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index != NSNotFound && index > 0) {
            UIViewController *parentController = self.navigationController.viewControllers[index-1];
            [self.navigationController popToViewController:parentController animated:YES];
        }
    }
}

#pragma mark - Default values

- (NSString *)defaultGroupName
{
    if (self.defaultGroupIndex > 0) {
        return [NSString stringWithFormat:@"DefaultGroup%d", (int)self.defaultGroupIndex];
    }
    return nil;
}

- (void)setDefaultGroupIndex:(NSInteger)defaultGroupIndex
{
    if (_defaultGroupIndex != defaultGroupIndex) {
        _defaultGroupIndex = defaultGroupIndex;
        self.defaultGroupSelector.selectedSegmentIndex = defaultGroupIndex;
        [self updateDefaultGroup];
    }
}

- (void)updateDefaultGroup
{
    NSString *defaultGroupName = self.defaultGroupName;
    for (TLIndexPathItem *item in self.indexPathController.items) {
        TKConfig *config = item.data;
        config.defaultGroupName = defaultGroupName;
    }
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self tableView:self.tableView configureCell:cell atIndexPath:indexPath];
    }
}

- (IBAction)defaultGroupChanged:(UISegmentedControl *)sender {
    NSDictionary *userInfo = @{kTKDefaultGroupNumberKey : @(sender.selectedSegmentIndex)};
    [[NSNotificationCenter defaultCenter] postNotificationName:kTKDefaultGroupNumberChangedNotification object:self userInfo:userInfo];
}

- (void)observeDefaultGroupChanged:(NSNotification *)notification
{
    NSNumber *defaultGroupNumber = [notification.userInfo objectForKey:kTKDefaultGroupNumberKey];
    self.defaultGroupIndex = [defaultGroupNumber integerValue];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = [self.indexPathController.dataModel sectionNameForSection:section];
    if ([sectionName isEqualToString:kTuneKitNoSectionName]) {
        return 0;
    }
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = [self.indexPathController.dataModel sectionNameForSection:section];
    if ([sectionName isEqualToString:kTuneKitNavigationSectionName]) {
        return @"More";
    }
    return sectionName;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLIndexPathItem *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];

    if ([item.data isKindOfClass:[TKNodeConfig class]]) {
        TKNodeConfig *config = item.data;
        TKControlPanelTableViewController *viewController = self.nodeViewControllerProvider(config.name);
        if (viewController) {
            viewController.defaultGroupIndex = self.defaultGroupIndex;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

#pragma mark - TLIndexPathControllerDelegate

- (void)controller:(TLIndexPathController *)controller didUpdateDataModel:(TLIndexPathUpdates *)updates
{
    [self updateDefaultGroup];
    [super controller:controller didUpdateDataModel:updates];
}

#pragma mark - Cell configuration

- (NSString *)tableView:(UITableView *)tableView cellIdentifierAtIndexPath:(NSIndexPath *)indexPath
{
    TLIndexPathItem *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    TKConfig *config = item.data;

    switch (config.type) {
        case TKConfigTypeNode:
            return @"Node";
            break;
        case TKConfigTypeButton:
            return @"Button";
            break;
        case TKConfigTypeSlider:
            return @"Slider";
            break;
        case TKConfigTypeSwitch:
            return @"Switch";
            break;
        case TKConfigTypeColorPicker:
            return @"ColorPicker";
            break;
        case TKConfigTypeLabel:
        case TKConfigTypeRate:
            return @"Label";
            break;
        default:
            return @"Cell";
            break;
    }
}

- (void)tableView:(UITableView *)tableView configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TLIndexPathItem *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    TKConfig *config = item.data;
    config.defaultGroupName = self.defaultGroupName;
    
    switch (config.type) {
        case TKConfigTypeNode:
            [self configureCell:cell forNodeConfig:(TKNodeConfig *)config];
            break;
        case TKConfigTypeButton:
            [self configureCell:cell forButtonConfig:(TKButtonConfig *)config];
            break;
        case TKConfigTypeSlider:
            [self configureCell:cell forSliderConfig:(TKSliderConfig *)config];
            break;
        case TKConfigTypeSwitch:
            [self configureCell:cell forSwitchConfig:(TKSwitchConfig *)config];
            break;
        case TKConfigTypeColorPicker:
            [self configureCell:cell forColorPickerConfig:(TKColorPickerConfig *)config];
            break;
        case TKConfigTypeLabel:
        case TKConfigTypeRate:
            [self configureCell:cell forLabelConfig:(TKLabelConfig *)config];
            break;
        default:
            break;
    }
}

- (void)configureCell:(UITableViewCell *)cell forNodeConfig:(TKNodeConfig *)config
{
    cell.textLabel.text = config.name;
}

- (void)configureCell:(UITableViewCell *)cell forButtonConfig:(TKButtonConfig *)config
{
    config.button = (UIButton *)[cell viewWithTag:1];
}

- (void)configureCell:(UITableViewCell *)cell forSliderConfig:(TKSliderConfig *)config
{
    config.nameLabel = (UILabel *)[cell viewWithTag:1];
    config.valueLabel = (UILabel *)[cell viewWithTag:2];
    config.slider = (UISlider *)[cell viewWithTag:3];
    config.slider.enabled = self.defaultGroupIndex > 0;
}

- (void)configureCell:(UITableViewCell *)cell forSwitchConfig:(TKSwitchConfig *)config
{
    config.nameLabel = (UILabel *)[cell viewWithTag:1];
    config.theSwitch = (UISwitch *)[cell viewWithTag:2];
    config.theSwitch.enabled = self.defaultGroupIndex > 0;
}

- (void)configureCell:(UITableViewCell *)cell forColorPickerConfig:(TKColorPickerConfig *)config
{
    config.nameLabel = (UILabel *)[cell viewWithTag:1];
    config.colorSpacePicker = (UISegmentedControl *)[cell viewWithTag:2];
    config.hexTextField = (UITextField *)[cell viewWithTag:3];
    config.sliders = [self view:cell viewsWithTags:@[@10, @11, @12, @13]];
    config.sliderLabels = [self view:cell viewsWithTags:@[@20, @21, @22, @23]];
    config.sliderValues = [self view:cell viewsWithTags:@[@30, @31, @32, @33]];
    UIView *colorPreviewsView = [cell viewWithTag:40];
    config.currentColorView = [colorPreviewsView viewWithTag:1];
    config.updatedColorView = [colorPreviewsView viewWithTag:2];
    
    for (UISlider *slider in config.sliders) {
        slider.enabled = self.defaultGroupIndex > 0;
    }
    
    colorPreviewsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"checkers"]];
}

- (void)configureCell:(UITableViewCell *)cell forLabelConfig:(TKLabelConfig *)config
{
    config.nameLabel = (UILabel *)[cell viewWithTag:1];
    config.valueLabel = (UILabel *)[cell viewWithTag:2];
}

- (NSArray *)view:(UIView *)view viewsWithTags:(NSArray *)tags
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSNumber *tag in tags) {
        [array addObject:[view viewWithTag:[tag integerValue]]];
    }
    return array;
}

@end
