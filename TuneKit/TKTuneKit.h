//
//  TKTuneKit.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSliderConfig.h"
#import "TKButtonConfig.h"

@interface TKTuneKit : NSObject

#pragma mark - Presenting control panels

+ (void)presentControlPanelWithConfigs:(NSArray *)configs;

@end