//
//  TKNodeConfig.h
//  TuneKit
//
//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKConfig.h"

@interface TKNodeConfig : TKConfig

#pragma mark - Creating node configs

+ (instancetype)configWithName:(NSString *)name
                      identifier:(NSString *)identifier;

@end
