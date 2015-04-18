//
//  RBBSpringAnimationViewController.m
//  Examples
//
//  Created by Tim Moose on 4/18/15.
//  Copyright (c) 2015 Tractable Labs. All rights reserved.
//

#import "RBBSpringAnimationViewController.h"
#import <TuneKit/TKRBBSpringAnimationBuilder.h>

@interface RBBSpringAnimationViewController ()
@property (strong, nonatomic) TKRBBSpringAnimationBuilder *springAnimationBuilder;
@end

@implementation RBBSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Animation";
    
    self.firstView.backgroundColor = [UIColor redColor];
    
    self.springAnimationBuilder = [TKRBBSpringAnimationBuilder builder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [TuneKit add:^{
        [TuneKit addButton:@"Animate" target:self selector:@selector(performAnimation)];
    } inPath:[TuneKit pathForViewController:self] sectionName:nil];
    [TuneKit add:^{
        [self.springAnimationBuilder addAllControls];
    } inPath:[TuneKit pathForViewController:self] sectionName:@"Spring Animation"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TuneKit removePath:[TuneKit pathForViewController:self]];
}

- (void)performAnimation
{
    RBBSpringAnimation *animation = [self.springAnimationBuilder animation];
    animation.duration = [animation durationForEpsilon:0.01] + 0.1;
    animation.keyPath = @"position.y";
    animation.fromValue = @(self.firstView.layer.position.y);
    self.verticalAlignment.constant = self.verticalAlignment.constant == -100.f ? 234.f : -100.f;
    [self.view layoutIfNeeded];
    animation.toValue = @(self.firstView.layer.position.y);
    [self.firstView.layer addAnimation:animation forKey:@"spring"];
}

@end
