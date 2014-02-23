//
//  TKConfig.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TKCallback)();
typedef void(^TKValueCallback)(id value);

@interface TKConfig : NSObject

@property (strong, nonatomic, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
