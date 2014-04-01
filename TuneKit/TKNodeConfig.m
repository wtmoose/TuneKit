//
//  TKNodeConfig.m
//  TuneKit
//
//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKNodeConfig.h"

@implementation TKNodeConfig

#pragma mark - Creating node configs

+ (instancetype)configWithName:(NSString *)name identifier:(NSString *)identifier
{
    TKNodeConfig *config = [[TKNodeConfig alloc] initWithName:name type:TKConfigTypeNode identifier:identifier];
    return config;
}

@end
