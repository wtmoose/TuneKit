//
//  PopAnimationViewController.m
//  Examples
//
//  Created by Tim Moose on 5/13/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "PopAnimationViewController.h"
#import <TuneKit/TKPOPSpringAnimationBuilder.h>
#import "UIColor+Hex.h"

@interface PopAnimationViewController ()
@property (strong, nonatomic) TKPOPSpringAnimationBuilder *springAnimationBuilder;
@end

@implementation PopAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Animation";
    
    self.view.backgroundColor = [UIColor colorWithHexRGB:0x3B5998];
    self.firstView.backgroundColor = [UIColor whiteColor];
    
    self.springAnimationBuilder = [TKPOPSpringAnimationBuilder builder];
    self.springAnimationBuilder.dynamicsTension = 0;
    self.springAnimationBuilder.dynamicsFriction = 50;
    self.springAnimationBuilder.dynamicsMass = 5;
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
    POPSpringAnimation *animation = [self.springAnimationBuilder animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    animation.toValue = @(-100.f);
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                self.verticalAlignment.constant = 234.f;
                [self.view layoutIfNeeded];
            }];
        });
    }];
    [self.verticalAlignment pop_addAnimation:animation forKey:@"spring"];
}

@end
