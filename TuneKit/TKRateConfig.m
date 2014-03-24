//
//  TKRateConfig.m
//  TuneKit
//
//  Created by Tim Moose on 3/9/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKRateConfig.h"

@interface TKRateConfig ()
@property (strong, nonatomic) NSMutableArray *times;
@property (nonatomic) CGFloat averageTimeInterval;
@end

@implementation TKRateConfig

#pragma mark - Value

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateValue];
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (NSString *)value
{
    //TODO use a formula for this
    NSString *format = @"%0.0f";
    if (self.averageTimeInterval < .001f) {
        format = @"%0.5f";
    } else if (self.averageTimeInterval < .01f) {
        format = @"%0.4f";
    } else if (self.averageTimeInterval < .1f) {
        format = @"%0.3f";
    } else if (self.averageTimeInterval < 1.f) {
        format = @"%0.2f";
    } else if (self.averageTimeInterval < 10.f) {
        format = @"%0.1f";
    } else {
        format = @"%0.0f";
    }
    return [NSString stringWithFormat:format, self.averageTimeInterval];
}

- (void)updateValue
{
    // TODO this is most likely highly inefficient, but probably
    // adequate for measuring things like framerate
    
    NSDate *now = [NSDate date];
    [self.times addObject:now];
    
    if ([self.times count] == 1) {
        self.averageTimeInterval = 0;
        return;
    }
    
    for (NSDate *time in [self.times copy]) {
        if ([self.times count] == 2) break;
        NSTimeInterval interval = [now timeIntervalSinceDate:time];
        if (interval > self.sampleInterval) {
            [self.times removeObject:time];
        }
    }
    
    NSDate *first = [self.times firstObject];
    NSTimeInterval interval = [now timeIntervalSinceDate:first];
    self.averageTimeInterval = interval == 0 ? 0 : (double)[self.times count] / interval;
}

#pragma mark - Creating rate configs

+ (TKLabelConfig *)configWithName:(NSString *)name identifier:(NSString *)identifier target:(id)target keyPath:(NSString *)keyPath sampleInterval:(NSTimeInterval)sampleInterval
{
    TKRateConfig *config = [[TKRateConfig alloc] initWithName:name type:TKConfigTypeRate identifier:identifier target:target keyPath:keyPath];
    config.sampleInterval = sampleInterval;
    config.times = [NSMutableArray array];
    return config;
}

@end
