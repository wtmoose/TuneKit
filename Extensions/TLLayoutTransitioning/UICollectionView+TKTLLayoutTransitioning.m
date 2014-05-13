//
//  UICollectionView+TKTLLayoutTransitioning.m
//  TuneKit
//
//  Created by Tim Moose on 4/6/14.
//  Copyright (c) 2014 tractablelabs.com. All rights reserved.
//

#import "UICollectionView+TKTLLayoutTransitioning.h"
#import <TLLayoutTransitioning/UICollectionView+TLTransitioning.h>
#import <TuneKit/TuneKit.h>

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
