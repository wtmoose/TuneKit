//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>
#import "TKGlobal.h"
#import "TKConfig.h"

@interface TKButtonConfig : TKConfig

#pragma mark - View bindings

@property (weak, nonatomic) UIButton *button;

#pragma mark - Creating button configs

+ (instancetype)configWithName:(NSString *)name
                        identifier:(NSString *)identifier
                            target:(id)target
                          selector:(SEL)selector;

+ (instancetype)configWithName:(NSString *)name
                        identifier:(NSString *)identifier
                     actionHanlder:(TKCallback)actionHanlder;

@end
