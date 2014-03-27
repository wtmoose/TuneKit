//
//  TKConfig.h
//  TuneKit
//
//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TKConfigType)
{
    TKConfigTypeNode,
    TKConfigTypeButton,
    TKConfigTypeSwitch,
    TKConfigTypeSlider,
    TKConfigTypeSegmentedControl,
    TKConfigTypeColorPicker,
    TKConfigTypeLabel,
    TKConfigTypeRate,
};

@interface TKConfig : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) TKConfigType type;
@property (strong, nonatomic, readonly) NSString *identifier;
@property (strong, nonatomic) NSString *defaultGroupName;

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type
                  identifier:(NSString *)identifier;

@end
