//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKLabelConfig.h"

@interface TKRateConfig : TKLabelConfig

@property (nonatomic) NSTimeInterval sampleInterval;

#pragma mark - Creating rate configs

+ (instancetype)configWithName:(NSString *)name
                      identifier:(NSString *)identifier
                          target:(id)target
                         keyPath:(NSString *)keyPath
                  sampleInterval:(NSTimeInterval)sampleInterval;

@end
