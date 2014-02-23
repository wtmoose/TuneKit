//
//  TKButtonConfig.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKConfig.h"

@interface TKButtonConfig : TKConfig

@property (weak, nonatomic) IBOutlet UIButton *button;

+ (TKButtonConfig *)configWithName:(NSString *)name target:(id)target selector:(SEL)selector;
+ (TKButtonConfig *)configWithName:(NSString *)name actionHanlder:(TKCallback)actionHanlder;

@end
