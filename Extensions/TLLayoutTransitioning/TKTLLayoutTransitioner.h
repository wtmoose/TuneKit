//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <Foundation/Foundation.h>
#import "TuneKit.h"
#import <TLLayoutTransitioning/TLTransitionLayout.h>
#import <TLLayoutTransitioning/UICollectionView+TLTransitioning.h>
#import "CAKeyframeAnimation+TKAHEasing.h"

@interface TKTLLayoutTransitioner : NSObject

#pragma mark - Configuring the transitioner

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) TLTransitionLayoutIndexPathPlacement placement;
@property (nonatomic) BOOL useDefaultPlacementAnchor;
@property (nonatomic) CGPoint placementAnchor;
@property (nonatomic) UIEdgeInsets placementInset;
@property (nonatomic) NSString *easingFunctionName;
@property (readonly, nonatomic) AHEasingFunction easingFunction;
@property (nonatomic) CGSize toSize;
@property (nonatomic) UIEdgeInsets toContentInset;

#pragma mark - Performing the transition

- (TLTransitionLayout *)transitionCollectionView:(UICollectionView *)collectionView
                                        toLayout:(UICollectionViewLayout *)layout
                             placementIndexPaths:(NSArray *)placementIndexPaths
                                      completion:(void(^)(BOOL completed, BOOL finish))completion;

/// returns the active transition layout while the transition is in progress
@property (readonly, weak, nonatomic) TLTransitionLayout *transitionLayout;

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls;

- (TKSliderConfig *)addDurationDurationControl;
- (TKPickerViewConfig *)addPlacementControl;
- (TKPickerViewConfig *)addEasingControl;

#pragma mark - Creating transitioners

+ (instancetype)transitioner;

@end
