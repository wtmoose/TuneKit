//
//  NSObject+Utils.m
//  TuneKit
//
//  Created by Tim Moose on 3/10/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)

+ (BOOL)nilSafeObject:(id)object isEqual:(id)other
{
    if (object == nil && object == nil) return YES;
    if (object == nil || other == nil) return NO;
    return [object isEqual:other];
}

@end
