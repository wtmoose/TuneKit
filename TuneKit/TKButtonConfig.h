//
//  TKButtonConfig.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGlobal.h"
#import "TKConfig.h"

@interface TKButtonConfig : TKConfig

#pragma mark - View bindings

@property (weak, nonatomic) UIButton *button;

#pragma mark - Creating button configs

+ (TKButtonConfig *)configWithName:(NSString *)name
                        identifier:(NSString *)identifier
                            target:(id)target
                          selector:(SEL)selector;

+ (TKButtonConfig *)configWithName:(NSString *)name
                        identifier:(NSString *)identifier
                     actionHanlder:(TKCallback)actionHanlder;

@end
