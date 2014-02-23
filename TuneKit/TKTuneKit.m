//
//  TKTuneKit.m
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKTuneKit.h"
#import "TKDialogViewController.h"
#import "TKControlPanelTableViewController.h"

@interface TKTuneKit ()
//@property (strong, nonatomic) NSMutableDictionary *tunersByName;
//@property (strong, nonatomic) TKDialogViewController *dialog;
@end

@implementation TKTuneKit

//- (id)init
//{
//    if (self = [super init]) {
//        _tunersByName = [NSMutableDictionary dictionary];
//    }
//    return self;
//}

+ (TKTuneKit *)sharedInstance
{
    static TKTuneKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TKTuneKit alloc] init];
    });
    return sharedInstance;
    
}

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

+ (void)presentControlPanelWithConfigs:(NSArray *)configs
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TKTuneKit" bundle:nil];
    TKControlPanelTableViewController *controlPanel = [storyboard instantiateViewControllerWithIdentifier:@"ControlPanel"];
    controlPanel.indexPathController.items = configs;

    TKDialogViewController *dialog = [storyboard instantiateViewControllerWithIdentifier:@"Dialog"];
    dialog.contentViewController = controlPanel;
    
    [dialog present];
    
//    tk.dialog = dialog;
//    
//    __weak TKTuneKit *weakTK = tk;
//    [dialog setDismissHandler:^{
//        [weakTK dismissDialog];
//    }];
//    
    
}

@end
