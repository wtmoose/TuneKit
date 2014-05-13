//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <UIKit/UIKit.h>

@class TKPickerViewConfig;

@interface UICollectionView (TKTLLayoutTransitioning)

+ (TKPickerViewConfig *)addIndexPathPlacementPickerView:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

@end
