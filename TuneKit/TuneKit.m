//
//  TuneKit.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TuneKit.h"

@interface TuneKit ()
//@property (strong, nonatomic) NSMutableDictionary *tunersByName;
@end

@implementation TuneKit

//- (id)init
//{
//    if (self = [super init]) {
//        _tunersByName = [NSMutableDictionary dictionary];
//    }
//    return self;
//}
//
//+ (TuneKit *)sharedInstance
//{
//    static TuneKit *sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[TuneKit alloc] init];
//    });
//    return sharedInstance;
//    
//}
//
//+ (NSDictionary *)tunersByName
//{
//    TuneKit *tk = [self sharedInstance];
//    return [NSDictionary dictionaryWithDictionary:tk.tunersByName];
//}
//
//+ (void)addTuner:(TKConfig *)tuner
//{
//    TuneKit *tk = [self sharedInstance];
//    [tk.tunersByName setObject:tuner forKey:tuner.name];
//}
//
//+ (TKConfig *)tunerForName:(NSString *)name
//{
//    TuneKit *tk = [self sharedInstance];
//    return [tk.tunersByName objectForKey:name];
//}

#pragma mark - Presenting control panels

+ (TKControlPanelTableViewController *)presentControlPanelWithConfigs:(NSArray *)configs
{
    return nil;
}

@end
