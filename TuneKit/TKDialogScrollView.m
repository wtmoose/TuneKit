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

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGRect contentRect = CGRectNull;
//    for (UIView *view in [self subviews]) {
//        if (CGRectEqualToRect(contentRect, CGRectNull)) {
//            contentRect = view.frame;
//        }
//        contentRect = CGRectIntersection(contentRect, view.frame);
//    }
//    
//    CGSize viewportSize = self.bounds.size;
//    CGSize scrollContentSize = viewportSize;
//    scrollContentSize.width += fabs(viewportSize.width - contentRect.size.width);
//    scrollContentSize.height += fabs(viewportSize.height - contentRect.size.height);
//    self.contentSize = scrollContentSize;
//    
//    CGPoint contentOrigin = CGPointMake(scrollContentSize.width / 2.f, scrollContentSize.height / 2.f);
//    contentOrigin.x -= CGRectGetWidth(contentRect) / 2.f;
//    contentOrigin.y -= CGRectGetHeight(contentRect) / 2.f;
//    
//    CGPoint translation = CGPointMake(contentOrigin.x - contentRect.origin.x, contentOrigin.y - contentRect.origin.y);
//    for (UIView *view in [self subviews]) {
//        CGPoint center = view.center;
//        center.x += translation.x;
//        center.y += translation.y;
//        view.center = center;
//    }
//}

@end
