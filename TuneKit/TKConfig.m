//
//  TKConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKConfig.h"

@class TKButtonConfig;
@class TKSliderConfig;
@class TKColorPickerConfig;

@implementation TKConfig

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type identifier:(NSString *)identifier
{
    if (self = [super init]) {
        _name = name;
        _type = type;
        _identifier = identifier;
    }
    return self;
}

@end
