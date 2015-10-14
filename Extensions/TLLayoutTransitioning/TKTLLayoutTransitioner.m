//  Created by Tim Moose on 3/28/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "TKTLLayoutTransitioner.h"
#import <TLLayoutTransitioning/TLTransitionLayout.h>
#import "UICollectionView+TKTLLayoutTransitioning.h"

static CGSize kTLLayoutTransitionerDefaultSize = (CGSize){-9999, -9999};
static UIEdgeInsets kTLLayoutTransitionerDefaultInset = (UIEdgeInsets){-9999, -9999, -9999, -9999};

@interface TKTLLayoutTransitioner ()
@property (strong, nonatomic) void(^completion)(BOOL completed, BOOL finish);
@property (strong, nonatomic) void(^internalCompletion)(BOOL completed, BOOL finish);
@property (readwrite, weak, nonatomic) TLTransitionLayout *transitionLayout;
@end

@implementation TKTLLayoutTransitioner

#pragma mark - Configuring the transition

- (void)setPlacementAnchor:(CGPoint)placementAnchor
{
    if (!CGPointEqualToPoint(_placementAnchor, placementAnchor)) {
        _placementAnchor = placementAnchor;
        self.useDefaultPlacementAnchor = CGPointEqualToPoint(kTLPlacementAnchorDefault, placementAnchor);
    }
}

- (void)setUseDefaultPlacementAnchor:(BOOL)useDefaultPlacementAnchor
{
    if (_useDefaultPlacementAnchor != useDefaultPlacementAnchor) {
        _useDefaultPlacementAnchor = useDefaultPlacementAnchor;
        if (useDefaultPlacementAnchor) {
            self.placementAnchor = kTLPlacementAnchorDefault;
        }
    }
}

- (AHEasingFunction)easingFunction
{
    return [CAKeyframeAnimation easingFunctionForName:self.easingFunctionName];
}

#pragma mark - Performing the transition

- (TLTransitionLayout *)transitionCollectionView:(UICollectionView *)collectionView
                                        toLayout:(UICollectionViewLayout *)layout
                             placementIndexPaths:(NSArray *)placementIndexPaths
                                      completion:(void (^)(BOOL, BOOL))completion
{
    CGSize toSize = self.toSize;
    if (CGSizeEqualToSize(toSize, kTLLayoutTransitionerDefaultSize)) {
        toSize = collectionView.bounds.size;
    }
    UIEdgeInsets toContentInset = self.toContentInset;
    if (UIEdgeInsetsEqualToEdgeInsets(toContentInset, kTLLayoutTransitionerDefaultInset)) {
        toContentInset = collectionView.contentInset;
    }    
    self.completion = completion;
    // TODO sanitize `easing` to ensure an actual easing curve is used
    TLTransitionLayout *transitionLayout = (TLTransitionLayout *)[collectionView
                                                                  transitionToCollectionViewLayout:layout
                                                                  duration:self.duration
                                                                  easing:self.easingFunction
                                                                  completion:self.internalCompletion];
    if (self.placement != TLTransitionLayoutIndexPathPlacementNone) {
        CGPoint placementAnchor = self.useDefaultPlacementAnchor ? kTLPlacementAnchorDefault : self.placementAnchor;
        CGPoint toOffset = [collectionView toContentOffsetForLayout:transitionLayout
                                                         indexPaths:placementIndexPaths
                                                          placement:self.placement
                                                    placementAnchor:placementAnchor
                                                     placementInset:self.placementInset
                                                             toSize:toSize
                                                     toContentInset:toContentInset];
        transitionLayout.toContentOffset = toOffset;
    }
    _transitionLayout = transitionLayout;
    return transitionLayout;
}

#pragma mark - Adding TuneKit controls

- (NSArray *)addAllControls
{
    NSMutableArray *controls = [NSMutableArray arrayWithCapacity:3];
    [controls addObject:[self addPlacementControl]];
    [controls addObject:[self addPlacementControl]];
    [controls addObject:[self addEasingControl]];
    return controls;
}

- (TKSliderConfig *)addDurationDurationControl
{
    return [TuneKit addSlider:@"Duration" target:self keyPath:@"duration" min:0 max:3];
}

- (TKPickerViewConfig *)addPlacementControl
{
    return [UICollectionView addIndexPathPlacementPickerView:@"Placement" target:self keyPath:@"placement"];
}

- (TKPickerViewConfig *)addEasingControl
{
    return [CAKeyframeAnimation addAHEasingFunctionNameConfig:@"Easing" target:self keyPath:@"easingFunctionName"];
}

#pragma mark - Creating transitions

+ (instancetype)transitioner
{
    return [[TKTLLayoutTransitioner alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        __weak TKTLLayoutTransitioner *weakSelf = self;
        [self setInternalCompletion:^(BOOL completed, BOOL finish) {
            if (weakSelf.completion) {
                weakSelf.completion(completed, finish);
            }
            weakSelf.transitionLayout = nil;
            weakSelf.completion = nil;
        }];
        _useDefaultPlacementAnchor = YES;
        _placementInset = UIEdgeInsetsZero;
        _easingFunctionName = kAHEasingLinearInterpolation;
        _toSize = kTLLayoutTransitionerDefaultSize;
        _toContentInset = kTLLayoutTransitionerDefaultInset;
    }
    return self;
}

@end
