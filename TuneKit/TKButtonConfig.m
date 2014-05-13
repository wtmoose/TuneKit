//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKButtonConfig.h"

#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)                    \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")                                         \

@interface TKButtonConfig ()
@property (strong, nonatomic) TKCallback actionHanlder;
@end

@implementation TKButtonConfig

#pragma mark - View bindings

- (void)setButton:(UIButton *)button
{
    [_button removeTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    _button = button;
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:self.name forState:UIControlStateNormal];
}

- (void)buttonTapped
{
    if (self.actionHanlder) {
        self.actionHanlder();
    }
}

#pragma mark - Creating button configs

+ (instancetype)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target selector:(SEL)selector
{
    return [self configWithName:name identifier:(NSString *)identifier actionHanlder:^{
        if ([target respondsToSelector:selector]) {
            SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([target performSelector:selector]);
        }
    }];
}

+ (instancetype)configWithName:(NSString *)name identifier:(NSString *)identifier actionHanlder:(TKCallback)actionHanlder
{
    TKButtonConfig *config = [[TKButtonConfig alloc] initWithName:name type:TKConfigTypeButton identifier:identifier];
    config.actionHanlder = actionHanlder;
    return config;
}

@end
