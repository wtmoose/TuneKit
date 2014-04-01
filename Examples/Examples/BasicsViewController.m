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
@property (strong, nonatomic) NSString *secondViewArea;
@property (nonatomic) BOOL debugSwitch;
@property (nonatomic) NSInteger debugSegmentedControl;
@property (nonatomic) NSString *debugPickerView;
@end

@implementation BasicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Basics";
    
    self.firstView.backgroundColor = [UIColor colorWithHexRGB:0x1694AE];
    
    self.debugSegmentedControl = 1;
    self.debugPickerView = @"Two";
    
    // color example
    [TuneKit add:^{

        [TuneKit addColorPicker:@"Color" target:self keyPath:@"firstView.backgroundColor"];

    } inPath:[TuneKit pathForViewController:self] sectionName:@"Color Example"];

    // transform example
    [TuneKit add:^{
        
        [TuneKit addSlider:@"Width" target:self keyPath:@"secondViewWidth.constant" min:50 max:250];

        [TuneKit addSlider:@"Height" target:self keyPath:@"secondViewHeight.constant" min:50 max:250];

        [TuneKit addLabel:@"Area" target:self keyPath:@"secondViewArea"];
        
        [TuneKit addRate:@"Changes per second" target:self keyPath:@"secondViewArea" sampleInterval:2];
        
    } inPath:[TuneKit pathForViewController:self] sectionName:@"Transform Example"];

    // todo example
    [TuneKit add:^{
        
        [TuneKit addSwitch:@"Switch Test" target:self keyPath:@"debugSwitch"];
        
        [TuneKit addLabel:@"Switch Value" target:self keyPath:@"debugSwitch"];

        [TuneKit addSegmentedControl:@"Segmented Control Test" target:self
                             keyPath:@"debugSegmentedControl"
                        segmentNames:@[@"One", @"Two", @"Three", @"Four"]
                       segmentValues:@[@(1), @(2), @(3), @(4)]];
        
        [TuneKit addLabel:@"Segmented Control Value" target:self keyPath:@"debugSegmentedControl"];

        [TuneKit addPickerView:@"Picker View Test" target:self keyPath:@"debugPickerView"
                   pickerNames:@[@"One", @"Two", @"Three", @"Four"]
                  pickerValues:@[@"One", @"Two", @"Three", @"Four"]];
        
        [TuneKit addLabel:@"Segmented Control Value" target:self keyPath:@"debugSegmentedControl"];

    } inPath:[TuneKit pathForViewController:self] sectionName:@"ToDo Example"];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize size = self.secondView.bounds.size;
    self.secondViewArea = [NSString stringWithFormat:@"%0.0f SQPT", size.width * size.height];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    // set default values for tunable parameters
//    self.animationDuration = 0.65;
//    self.animationDampingRatio = 0.3;
//    self.animationScale = 0.75;
//    self.animationView.backgroundColor = [UIColor colorWithHexRGB:0x1694AE];
//    
//    // add color example
//    [TuneKit add:^{
//        
//        // add a color picker to set the animation view's color
//        [TuneKit addColorPicker:@"Animation View's Color" target:self keyPath:@"animationView.backgroundColor"];
//        
//    } inPath:[TuneKit pathForViewController:self] sectionName:@"Color Example"];
//    
//    // add animation example
//    [TuneKit add:^{
//        
//        // add a button to start the animation
//        [TuneKit addButton:@"Run Animation" target:self selector:@selector(runAnimation)];
//        
//        // add a slider to adjust the animation duration
//        [TuneKit addSlider:@"Duration" target:self keyPath:@"animationDuration" min:0.1 max:1.5];
//        
//        // add a slider to adjust the animation damping ratio (for a spring animation)
//        [TuneKit addSlider:@"Damping Ratio" target:self keyPath:@"animationDampingRatio" min:0 max:1];
//        
//        // add a slider to adjust the animation scale factor
//        [TuneKit addSlider:@"Scale" target:self keyPath:@"animationScale" min:0.25 max:1.25];
//        
//    } inPath:[TuneKit pathForViewController:self] sectionName:@"Animation Example"];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];    
    [TuneKit removePath:[TuneKit pathForViewController:self]];
}

//- (void)runAnimation
//{
//    CGFloat width = self.animationViewWidth.constant;
//    CGFloat height = self.animationViewHeight.constant;
//    
//    // bounce
//    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDampingRatio initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        
//        self.animationViewWidth.constant = width * self.animationScale;
//        self.animationViewHeight.constant = height * self.animationScale;
//        [self.animationView layoutIfNeeded];
//        
//    } completion:^(BOOL finished) {
//        
//        // bounce back
//        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDampingRatio initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            
//            self.animationViewWidth.constant = width;
//            self.animationViewHeight.constant = height;
//            [self.animationView layoutIfNeeded];
//            
//        } completion:nil];
//        
//    }];
//}

@end
