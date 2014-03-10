//
//  TKLabelConfig.m
//  TuneKit
//
//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

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

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type target:(id)target keyPath:(NSString *)keyPath
{
    if (self = [super initWithName:name type:type]) {
        _target = target;
        _keyPath = keyPath;
        [target addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

+ (TKLabelConfig *)configWithName:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    TKLabelConfig *config = [[TKLabelConfig alloc] initWithName:name type:TKConfigTypeLabel target:target keyPath:keyPath];
    return config;
}

@end
