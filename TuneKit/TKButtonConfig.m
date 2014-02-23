//
//  TKButtonConfig.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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
}

- (void)buttonTapped
{
    if (self.actionHanlder) {
        self.actionHanlder();
    }
}

#pragma mark - Creating button configs

+ (TKButtonConfig *)configWithName:(NSString *)name target:(id)target selector:(SEL)selector
{
    return [self configWithName:name actionHanlder:^{
        if ([target respondsToSelector:selector]) {
            SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([target performSelector:selector]);
        }
    }];
}

+ (TKButtonConfig *)configWithName:(NSString *)name actionHanlder:(TKCallback)actionHanlder
{
    TKButtonConfig *config = [[TKButtonConfig alloc] initWithName:name];
    config.actionHanlder = actionHanlder;
    return config;
}

@end
