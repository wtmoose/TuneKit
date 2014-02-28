//
//  TKDialogViewController.m
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKDialogViewController.h"

@interface TKDialogViewController ()
@property (weak, nonatomic) NSLayoutConstraint *originYConstraint;
@property (weak, nonatomic) NSLayoutConstraint *originXConstraint;
@end

@implementation TKDialogViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.dismissButton addTarget:self action:@selector(dismiss)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self themeViewController:self];
}

#pragma mark - Content

- (void)setContentViewController:(UIViewController *)contentViewController
{
    [self view];
    [_contentViewController removeFromParentViewController];
    [_contentViewController.view removeFromSuperview];
    _contentViewController = contentViewController;
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = self.contentView.bounds;
    contentViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
    contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:contentViewController.view];
}

#pragma mark - Presenting

- (void)present
{
    UIView *parentView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    self.originYConstraint = [NSLayoutConstraint constraintWithItem:parentView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0];
    self.originXConstraint = [NSLayoutConstraint constraintWithItem:parentView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0];
    
    CGRect frame = CGRectMake(0, 0, 280, 528);
    self.view.frame = frame;
    
    [parentView addSubview:self.view];
    
    [parentView addConstraints:@[self.originYConstraint, self.originXConstraint]];
    
    [self.view layoutIfNeeded];
}

- (IBAction)dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.originYConstraint = nil;
    self.originXConstraint = nil;
}


#pragma mark - Theme

- (void)themeViewController:(TKDialogViewController *)controller
{
    CGFloat cornerRadius = 5.f;
    
    CALayer *contentLayer = controller.containerView.layer;
    contentLayer.cornerRadius = cornerRadius;
    contentLayer.borderColor = [UIColor colorWithWhite:0.75 alpha:1].CGColor;
    contentLayer.borderWidth = 1;
    contentLayer.masksToBounds = YES;
    
    CALayer *layer = self.view.layer;
    layer.cornerRadius = cornerRadius;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    layer.shadowOffset = CGSizeMake(0.f, 1.5f);
    layer.shadowOpacity = 0.3f;
    layer.shadowRadius = 3.f;
    layer.shadowPath = CGPathCreateWithRoundedRect(layer.bounds, cornerRadius, cornerRadius, NULL);
}

@end
