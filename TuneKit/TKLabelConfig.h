//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKLabelConfig : TKConfig

@property (readonly, nonatomic) NSString *value;

#pragma mark - View bindings

@property (weak, nonatomic) UILabel *valueLabel;
@property (weak, nonatomic) UILabel *nameLabel;

#pragma mark - Creating label configs

- (instancetype)initWithName:(NSString *)name
                        type:(TKConfigType)type
                  identifier:(NSString *)identifier
                      target:(id)target
                     keyPath:(NSString *)keyPath;

+ (instancetype)configWithName:(NSString *)name
                       identifier:(NSString *)identifier
                           target:(id)target
                          keyPath:(NSString *)keyPath;

@end
