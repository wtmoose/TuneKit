//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKLabelConfig.h"

@interface TKLabelConfig ()
@property (weak, nonatomic) id target;
@property (strong, nonatomic) NSString *keyPath;
@end

@implementation TKLabelConfig

- (void)dealloc
{
    if (self.target) {
        [self.target removeObserver:self forKeyPath:self.keyPath];
    }
}


#pragma mark - Model bindings

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateValueViews];
}

- (NSString *)value
{
    return [self.target valueForKeyPath:self.keyPath];
}

#pragma mark - View bindings

- (void)setValueLabel:(UILabel *)valueLabel
{
    if (_valueLabel != valueLabel) {
        _valueLabel = valueLabel;
        [self updateValueViews];
    }
}

- (void)setNameLabel:(UILabel *)nameLabel
{
    if (_nameLabel != nameLabel) {
        _nameLabel = nameLabel;
        nameLabel.text = [self.name uppercaseString];
    }
}

#pragma mark - Value

- (void)updateValueViews
{
    self.valueLabel.text = [NSString stringWithFormat:@"%@", self.value];
}

#pragma mark - Creating label configs

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    if (self = [super initWithName:name type:type identifier:identifier]) {
        _target = target;
        _keyPath = keyPath;
        [target addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

+ (instancetype)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath
{
    TKLabelConfig *config = [[TKLabelConfig alloc] initWithName:name type:TKConfigTypeLabel identifier:identifier target:target keyPath:keyPath];
    return config;
}

@end
