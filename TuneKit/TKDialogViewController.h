//
//  TKDialogViewController.h
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKDialogViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *titleBar;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIButton *dismissButton;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

@property (weak, nonatomic) UIViewController *contentViewController;

- (void)present;

- (IBAction)dismiss;

@end
