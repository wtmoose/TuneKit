//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKConfig.h"

@class TKButtonConfig;
@class TKSliderConfig;
@class TKColorPickerConfig;

NSString *kTKConfigTunedChanged = @"kTKConfigTunedChanged";

@implementation TKConfig

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type identifier:(NSString *)identifier
{
    if (self = [super init]) {
        _name = name;
        _type = type;
        _identifier = identifier;
        _isTuned = NO;
    }
    return self;
}

@end
