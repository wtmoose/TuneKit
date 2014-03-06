//
//  TKSwitchConfig.h
//  TuneKit
//
//  Created by Tim Moose on 3/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKSwitchConfig : TKConfig

@property (nonatomic) BOOL value;

#pragma mark - View bindings

@property (weak, nonatomic) UISwitch *theSwitch;
@property (weak, nonatomic) UILabel *nameLabel;

#pragma mark - Creating slider configs

+ (TKSwitchConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

@end
