//
//  TKLabelConfig.h
//  TuneKit
//
//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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

+ (TKLabelConfig *)configWithName:(NSString *)name
                       identifier:(NSString *)identifier
                           target:(id)target
                          keyPath:(NSString *)keyPath;

@end
