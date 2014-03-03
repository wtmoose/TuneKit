//
//  TKDialogViewController.m
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKDialogViewController.h"

@interface TKDialogViewController ()
@property (weak, nonatomic) NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) NSLayoutConstraint *bottomConstraint;
@end

@implementation TKDialogViewController

#pragma mark - View controller lifecycle

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    [self.dismissButton addTarget:self action:@selector(dismiss)
//                 forControlEvents:UIControlEventTouchUpInside];
//}

//#pragma mark - Content
//
//- (void)setContentViewController:(UIViewController *)contentViewController
//{
//    [self view];
//    [_contentViewController removeFromParentViewController];
//    [_contentViewController.view removeFromSuperview];
//    _contentViewController = contentViewController;
//    [self addChildViewController:contentViewController];
//    contentViewController.view.frame = self.contentView.bounds;
//    contentViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
//    contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.contentView addSubview:contentViewController.view];
//}

#pragma mark - Presenting

- (void)presentAtLeftOrigin:(CGFloat)leftOrigin
{
    static CGFloat width = 280.f;
    
    UIView *parentView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:parentView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:20.f];
    self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:parentView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:leftOrigin];
    
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:parentView
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeBottom
                                                     multiplier:1.f
                                                       constant:20.f];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.f
                                                                        constant:width];
    

    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [parentView addSubview:self.view];
    
    [parentView addConstraints:@[self.topConstraint, self.leftConstraint, self.bottomConstraint, widthConstraint]];
    
    [self.view layoutIfNeeded];
}

- (IBAction)dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.topConstraint = nil;
    self.leftConstraint = nil;
    self.bottomConstraint = nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self themeViewController:self];
}

#pragma mark - Theme

- (void)themeViewController:(TKDialogViewController *)controller
{
    controller.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat cornerRadius = 5.f;
    
//    CALayer *contentLayer = controller.containerView.layer;
    CALayer *contentLayer = self.view.layer;
    contentLayer.cornerRadius = cornerRadius;
    contentLayer.borderColor = [UIColor colorWithWhite:0.75 alpha:1].CGColor;
    contentLayer.borderWidth = 1;
    contentLayer.masksToBounds = YES;
    
//    CALayer *layer = self.view.layer;
//    layer.cornerRadius = cornerRadius;
//    layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
//    layer.shadowOffset = CGSizeMake(0.f, 1.5f);
//    layer.shadowOpacity = 0.3f;
//    layer.shadowRadius = 3.f;
//    layer.shadowPath = CGPathCreateWithRoundedRect(layer.bounds, cornerRadius, cornerRadius, NULL);
}

@end
