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
        default:
            break;
    }
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forSliderConfig:(TKSliderConfig *)config
{
    config.nameLabel = (UILabel *)[cell viewWithTag:1];
    config.valueLabel = (UILabel *)[cell viewWithTag:2];
    config.slider = (UISlider *)[cell viewWithTag:3];
}

- (void)configureCell:(UITableViewCell *)cell forButtonConfig:(TKButtonConfig *)config
{
    config.button = (UIButton *)[cell viewWithTag:1];
}

@end
