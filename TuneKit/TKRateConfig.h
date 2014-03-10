//
//  TKRateConfig.h
//  TuneKit
//
//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKLabelConfig.h"

@interface TKRateConfig : TKLabelConfig

@property (nonatomic) NSTimeInterval sampleInterval;

#pragma mark - Creating rate configs

+ (TKRateConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath sampleInterval:(NSTimeInterval)sampleInterval;

@end