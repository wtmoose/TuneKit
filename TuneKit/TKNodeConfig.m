//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKNodeConfig.h"

@implementation TKNodeConfig

#pragma mark - Creating node configs

+ (instancetype)configWithName:(NSString *)name identifier:(NSString *)identifier
{
    TKNodeConfig *config = [[TKNodeConfig alloc] initWithName:name type:TKConfigTypeNode identifier:identifier];
    return config;
}

@end
