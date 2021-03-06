//
//  ViewController.m
//  Examples
//
//  Created by Tim Moose on 2/11/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "SelectorTableViewController.h"
#import <TLIndexPathTools/TLIndexPathItem.h>
#import <TuneKit/TuneKit.h>

@implementation SelectorTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TLIndexPathItem *basicsItem = [[TLIndexPathItem alloc] initWithIdentifier:@"Basics"
                                                                  sectionName:nil
                                                               cellIdentifier:nil
                                                                         data:@"Demonstrates some basic uses for TuneKit."];

    TLIndexPathItem *animationsItem = [[TLIndexPathItem alloc] initWithIdentifier:@"Animations"
                                                                  sectionName:nil
                                                               cellIdentifier:nil
                                                                         data:@"Show how to easily tune animations using the various TuneKit animation convenience classes, such as UIViewSpringAnimator."];

    TLIndexPathItem *popItem = [[TLIndexPathItem alloc] initWithIdentifier:@"Pop"
                                                                  sectionName:nil
                                                               cellIdentifier:nil
                                                                         data:@"Integration with Facebook's Pop animation framework (experimental)."];

    TLIndexPathItem *rbbItem = [[TLIndexPathItem alloc] initWithIdentifier:@"RBBSpringAnimation"
                                                               sectionName:nil
                                                            cellIdentifier:nil
                                                                      data:@"Integration with RBBSpringAnimation."];

    self.indexPathController.items = @[basicsItem, animationsItem, popItem, rbbItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSegueWithIdentifier:@"MainDetail" sender:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // present the control panel
    [TuneKit presentControlPanelAtLeftOrigin:350.f options:0];
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
