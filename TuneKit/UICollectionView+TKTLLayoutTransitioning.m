//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "UICollectionView+TKTLLayoutTransitioning.h"
#import <TLLayoutTransitioning/UICollectionView+TLTransitioning.h>
#import "TuneKit.h"

@implementation UICollectionView (TKTLLayoutTransitioning)

+ (TKPickerViewConfig *)addIndexPathPlacementPickerView:(NSString *)name target:(id)target keyPath:(NSString *)keyPath
{
    if ([TuneKit isEnabled]) {
        NSArray *names = @[
                           @"Minimal",
                           @"Visible",
                           @"Center",
                           @"Top",
                           @"Left",
                           @"Bottom",
                           @"Right"];
        NSArray *values = @[
                            @(TLTransitionLayoutIndexPathPlacementMinimal),
                            @(TLTransitionLayoutIndexPathPlacementVisible),
                            @(TLTransitionLayoutIndexPathPlacementCenter),
                            @(TLTransitionLayoutIndexPathPlacementTop),
                            @(TLTransitionLayoutIndexPathPlacementLeft),
                            @(TLTransitionLayoutIndexPathPlacementBottom),
                            @(TLTransitionLayoutIndexPathPlacementRight)];
        return [TuneKit addPickerView:name target:target keyPath:keyPath pickerNames:names pickerValues:values];
    }
    return nil;
}

@end
