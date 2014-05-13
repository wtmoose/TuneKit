//  Created by Tim Moose on 3/5/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKSwitchConfig : TKConfig

@property (nonatomic) BOOL value;

#pragma mark - View bindings

@property (weak, nonatomic) UISwitch *theSwitch;
@property (weak, nonatomic) UILabel *nameLabel;

#pragma mark - Creating slider configs

+ (instancetype)configWithName:(NSString *)name
                        identifier:(NSString *)identifier
                            target:(id)target
                           keyPath:(NSString *)keyPath;

@end
