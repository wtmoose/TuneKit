//
//  TuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKControlPanelTableViewController.h"

@interface TuneKit : NSObject

#pragma mark - Presenting control panels

+ (TKControlPanelTableViewController *)presentControlPanelWithConfigs:(NSArray *)configs;

@end
