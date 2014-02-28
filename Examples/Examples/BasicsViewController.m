//
//  BasicsViewController.m
//  Examples
//
//  Created by Tim Moose on 2/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "BasicsViewController.h"
#import <TuneKit/TuneKit.h>
#import "UIColor+Hex.h"

@interface BasicsViewController ()
@property (strong, nonatomic) IBOutlet UIView *animationView;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat animationDampingRatio;
@property (nonatomic) CGFloat animationScale;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *animationViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *animationViewHeight;
@end

@implementation BasicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set default values for tunable parameters
    self.animationDuration = 0.65;
    self.animationDampingRatio = 0.3;
    self.animationScale = 0.75;
    self.animationView.backgroundColor = [UIColor colorWithHexRGB:0x1694AE];
    
    // add a button to start the animation
    [TuneKit addButton:@"Run Animation" target:self selector:@selector(runAnimation)];
    
    // add a slider to adjust the animation duration
    [TuneKit addSlider:@"Duration" target:self keyPath:@"animationDuration" min:0.1 max:1.5];
    
    // add a slider to adjust the animation damping ratio (for a spring animation)
    [TuneKit addSlider:@"Damping Ratio" target:self keyPath:@"animationDampingRatio" min:0 max:1];

    // add a slider to adjust the animation scale factor
    [TuneKit addSlider:@"Scale" target:self keyPath:@"animationScale" min:0.25 max:1.25];

    // add a color picker to set the animation view's color
    [TuneKit addColorPicker:@"Color" target:self keyPath:@"animationView.backgroundColor"];
    
    // present the control panel (automatically)
    [TuneKit presentControlPanel];
}

- (void)runAnimation
{
    CGFloat width = self.animationViewWidth.constant;
    CGFloat height = self.animationViewHeight.constant;
    
    // bounce
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDampingRatio initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.animationViewWidth.constant = width * self.animationScale;
        self.animationViewHeight.constant = height * self.animationScale;
        [self.animationView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        // bounce back
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDampingRatio initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.animationViewWidth.constant = width;
            self.animationViewHeight.constant = height;
            [self.animationView layoutIfNeeded];
            
        } completion:nil];
        
    }];
}

@end
