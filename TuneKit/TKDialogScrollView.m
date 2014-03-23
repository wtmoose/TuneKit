//
//  TKModalView.m
//  TuneKit
//
//  Created by Tim Moose on 3/7/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKDialogScrollView.h"

@implementation TKDialogScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    return view == self ? nil : view;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![touch.view isKindOfClass:[UISlider class]];
}

@end
