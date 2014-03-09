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

@interface TKControlPanelTableViewController ()
@end

@implementation TKControlPanelTableViewController

#pragma mark - View controller lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pathChanged:)
                                                 name:kTuneKitPathChangedNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pathRemoved:)
                                                 name:kTuneKitPathRemovedNotification
                                               object:nil];
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
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index != NSNotFound && index > 0) {
            UIViewController *parentController = self.navigationController.viewControllers[index-1];
            [self.navigationController popToViewController:parentController animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    TLIndexPathItem *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    TKConfig *config = item.data;
    
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
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLIndexPathItem *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];

    if ([item.data isKindOfClass:[TKNodeConfig class]]) {
        TKNodeConfig *config = item.data;
        UIViewController *viewController = self.nodeViewControllerProvider(config.name);
        if (viewController) {
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
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
}

- (void)configureCell:(UITableViewCell *)cell forSwitchConfig:(TKSwitchConfig *)config
{
    config.nameLabel = (UILabel *)[cell viewWithTag:1];
    config.theSwitch = (UISwitch *)[cell viewWithTag:2];
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
