//
//  TKTableViewController.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKControlPanelTableViewController.h"
#import "TKButtonConfig.h"
#import "TKSliderConfig.h"
#import "TKColorPickerConfig.h"

@interface TKControlPanelTableViewController ()
@end

@implementation TKControlPanelTableViewController

- (NSString *)tableView:(UITableView *)tableView cellIdentifierAtIndexPath:(NSIndexPath *)indexPath
{
    TKConfig *config = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    
    switch (config.type) {
        case TKConfigTypeButton:
            return @"Button";
            break;
        case TKConfigTypeSlider:
            return @"Slider";
            break;
        case TKConfigTypeColorPicker:
            return @"ColorPicker";
            break;
        default:
            return @"Cell";
            break;
    }
}

#pragma mark - UITableViewDataModel

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    TKConfig *config = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    
    switch (config.type) {
        case TKConfigTypeButton:
            [self configureCell:cell forButtonConfig:(TKButtonConfig *)config];
            break;
        case TKConfigTypeSlider:
            [self configureCell:cell forSliderConfig:(TKSliderConfig *)config];
            break;
        case TKConfigTypeColorPicker:
            [self configureCell:cell forColorPickerConfig:(TKColorPickerConfig *)config];
        default:
            break;
    }
    
    return cell;
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

- (NSArray *)view:(UIView *)view viewsWithTags:(NSArray *)tags
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSNumber *tag in tags) {
        [array addObject:[view viewWithTag:[tag integerValue]]];
    }
    return array;
}

@end
