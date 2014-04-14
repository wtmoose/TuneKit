//
//  TKDialogViewController.h
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKDialogViewController : UINavigationController

//@property (strong, nonatomic) IBOutlet UIView *titleBar;
//@property (strong, nonatomic) IBOutlet UIView *containerView;
//@property (strong, nonatomic) IBOutlet UIView *contentView;
//@property (strong, nonatomic) IBOutlet UIButton *dismissButton;

//@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

//@property (weak, nonatomic) UIViewController *contentViewController;

- (void)presentAtLeftOrigin:(CGFloat)leftOrigin;

- (IBAction)dismiss;

- (IBAction)toggleExpandedCollapsed;

@property (nonatomic) BOOL collapsed;
- (void)setCollapsed:(BOOL)collapsed animated:(BOOL)animated;

@property (nonatomic) BOOL hidden;
- (void)setHidden:(BOOL)hidden afterDelay:(NSTimeInterval)delay;

@end
