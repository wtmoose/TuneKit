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
}

#pragma mark - Presenting

- (void)present
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController addChildViewController:self];
    UIView *rootView = rootViewController.view;
    
    self.originYConstraint = [NSLayoutConstraint constraintWithItem:rootView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0];
    self.originXConstraint = [NSLayoutConstraint constraintWithItem:rootView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0];
    
    [rootView addSubview:self.view];
    
    [rootView addConstraints:@[self.originYConstraint, self.originXConstraint]];
}

- (IBAction)dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.originYConstraint = nil;
    self.originXConstraint = nil;
}

@end
