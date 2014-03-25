//
//  TKTableViewController.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLIndexPathTools/TLTableViewController.h>

@interface TKControlPanelTableViewController : TLTableViewController
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) TKControlPanelTableViewController *(^nodeViewControllerProvider)(NSString *nodeName);
- (IBAction)dismiss;
@end
