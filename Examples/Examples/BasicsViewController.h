//
//  BasicsViewController.h
//  Examples
//
//  Created by Tim Moose on 2/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *firstView;

@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondViewHeight;

@property (strong, nonatomic) IBOutlet UIView *thirdView;

@end
