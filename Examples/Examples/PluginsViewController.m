//
//  DynamicsViewController.m
//  Examples
//
//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "PluginsViewController.h"
#import <TuneKit/TuneKit.h>
#import "UIColor+Hex.h"

@interface PluginsViewController ()
@property (nonatomic) CGFloat scale;
@property (strong, nonatomic) TKUIViewAnimation *scaleAnimation;
@property (strong, nonatomic) TKUIViewAnimation *returnAnimation;
@end

@implementation PluginsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Plugins";

    self.scaleAnimation = [TKUIViewAnimation animimationWithName:@"Scale"];
    self.returnAnimation = [TKUIViewAnimation animimationWithName:@"Return"];
    
    self.scale = .75;
    
    self.scaleAnimation.duration = .5;
    self.scaleAnimation.delay = 0;
    self.scaleAnimation.easingCurve = UIViewAnimationOptionCurveEaseOut;
    
    self.returnAnimation.duration = .5;
    self.returnAnimation.delay = .25;
    self.returnAnimation.easingCurve = UIViewAnimationOptionCurveEaseIn;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [TuneKit add:^{

        [TuneKit addButton:@"Animate" target:self selector:@selector(performAnimation)];

    } inPath:[TuneKit pathForViewController:self] sectionName:nil];

    [TuneKit add:^{

        [TuneKit addSlider:@"Scale" target:self keyPath:@"scale" min:.5 max:1.25];
        [self.scaleAnimation addControls];

    } inPath:[TuneKit pathForViewController:self] sectionName:@"Scale Animation"];

    [TuneKit add:^{

        [self.returnAnimation addControls];

    } inPath:[TuneKit pathForViewController:self] sectionName:@"Return Animation"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TuneKit removePath:[TuneKit pathForViewController:self]];
}

- (void)performAnimation
{
    __weak PluginsViewController *weakSelf = self;
    [self.scaleAnimation setAnimations:^{
        weakSelf.firstViewWidth.constant *= weakSelf.scale;
        weakSelf.firstViewHeight.constant *= weakSelf.scale;
        [weakSelf.view layoutIfNeeded];
    }];
    [self.returnAnimation setAnimations:^{
        weakSelf.firstViewWidth.constant /= weakSelf.scale;
        weakSelf.firstViewHeight.constant /= weakSelf.scale;
        [weakSelf.view layoutIfNeeded];
    }];
    [self.scaleAnimation setCompletion:^(BOOL finished) {
        if (finished) {
            [weakSelf.returnAnimation performAnimation];
        }
    }];
    [self.scaleAnimation performAnimation];
}

@end
