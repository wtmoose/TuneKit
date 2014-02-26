//
//  ViewController.m
//  Examples
//
//  Created by Tim Moose on 2/11/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "SelectorTableViewController.h"
#import <TLIndexPathTools/TLIndexPathItem.h>

@implementation SelectorTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TLIndexPathItem *basicsItem = [[TLIndexPathItem alloc] initWithIdentifier:@"Basics"
                                                                  sectionName:nil
                                                               cellIdentifier:nil
                                                                         data:@"Basic usage."];
    
    self.indexPathController.items = @[basicsItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSegueWithIdentifier:@"MainDetail" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    TLIndexPathItem *item = [self.indexPathController.dataModel itemAtIndexPath:indexPath];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
    textLabel.text = item.identifier;
    detailLabel.text = item.data;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self.indexPathController.dataModel identifierAtIndexPath:indexPath];
    [self performSegueWithIdentifier:identifier sender:self];
}

@end
