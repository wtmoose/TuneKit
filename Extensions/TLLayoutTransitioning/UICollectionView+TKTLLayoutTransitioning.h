//
//  UICollectionView+TKTLLayoutTransitioning.h
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 tractablelabs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKPickerViewConfig;

@interface UICollectionView (TKTLLayoutTransitioning)

+ (TKPickerViewConfig *)addIndexPathPlacementPickerView:(NSString *)name target:(id)target keyPath:(NSString *)keyPath;

@end
