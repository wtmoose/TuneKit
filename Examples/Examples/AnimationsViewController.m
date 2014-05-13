//
//  DynamicsViewController.m
//  Examples
//
//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "AnimationsViewController.h"
#import <TuneKit/TuneKit.h>
#import "UIColor+Hex.h"

@interface AnimationsViewController ()
@property (nonatomic) CGFloat scale;
@property (strong, nonatomic) TKUIViewAnimator *scaleAnimator;
@property (strong, nonatomic) TKUIViewSpringAnimator *returnAnimator;
@end

@implementation AnimationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Animation";
    
    self.firstView.backgroundColor = [UIColor colorWithHexRGB:0x625592];

    self.scaleAnimator = [TKUIViewAnimator animator];
    self.returnAnimator = [TKUIViewSpringAnimator animator];
    
    self.scale = .75;
    
    self.scaleAnimator.duration = .25;
    self.scaleAnimator.delay = 0;
    self.scaleAnimator.easing = UIViewAnimationOptionCurveEaseOut;
    
    self.returnAnimator.duration = .7;
    self.returnAnimator.delay = .25;
    self.returnAnimator.damping = 0.25;
    self.returnAnimator.initialVelocity = 0;
    self.returnAnimator.easing = UIViewAnimationOptionCurveEaseInOut;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [TuneKit add:^{
        [TuneKit addButton:@"Animate" target:self selector:@selector(performAnimation)];
    } inPath:[TuneKit pathForViewController:self] sectionName:nil];
    [TuneKit add:^{
        [TuneKit addSlider:@"Scale" target:self keyPath:@"scale" min:.5 max:1.25];
        [self.scaleAnimator addAllControls];
    } inPath:[TuneKit pathForViewController:self] sectionName:@"Scale Animation (Basic)"];
    [TuneKit add:^{
        [self.returnAnimator addAllControls];
    } inPath:[TuneKit pathForViewController:self] sectionName:@"Return Animation (Spring)"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TuneKit removePath:[TuneKit pathForViewController:self]];
}

- (void)performAnimation
{
    __weak AnimationsViewController *weakSelf = self;
    [self.scaleAnimator animateWithAnimations:^{
        weakSelf.firstViewWidth.constant *= weakSelf.scale;
        weakSelf.firstViewHeight.constant *= weakSelf.scale;
        [weakSelf.view layoutIfNeeded];
    } withCompletion:^(BOOL finished) {
        if (finished) {
            [weakSelf.returnAnimator animateWithAnimations:^{
                weakSelf.firstViewWidth.constant /= weakSelf.scale;
                weakSelf.firstViewHeight.constant /= weakSelf.scale;
                [weakSelf.view layoutIfNeeded];
            } withCompletion:nil];
        }
    }];
}

@end
