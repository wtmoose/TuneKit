//  Created by Tim Moose on 2/21/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TKConfigType)
{
    TKConfigTypeNode,
    TKConfigTypeButton,
    TKConfigTypeSwitch,
    TKConfigTypeSlider,
    TKConfigTypeSegmentedControl,
    TKConfigTypePickerView,
    TKConfigTypeColorPicker,
    TKConfigTypeLabel,
    TKConfigTypeRate,
};

/**
 Notification sent to the default center when the value of `isTuned` changes.
 */
extern NSString *kTKConfigTunedChanged;

@interface TKConfig : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) TKConfigType type;
@property (strong, nonatomic, readonly) NSString *identifier;
@property (strong, nonatomic) NSString *defaultGroupName;
@property (readonly, nonatomic) BOOL isTuned;

- (instancetype)initWithName:(NSString *)name type:(TKConfigType)type
                  identifier:(NSString *)identifier;

@end
