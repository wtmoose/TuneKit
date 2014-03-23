//
//  DynamicsViewController.m
//  Examples
//
//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "DynamicsViewController.h"
#import <TuneKit/TuneKit.h>
#import "UIColor+Hex.h"

@interface DynamicsViewController ()
@property (strong, nonatomic) IBOutlet UIView *boundaryView;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *actionViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *actionViewLeft;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *actionViewPan;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIColor *color;
@end

@implementation DynamicsViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.actionView.backgroundColor = [UIColor colorWithHexRGB:0xB95861];
    self.boundaryView.backgroundColor = [UIColor colorWithHexRGB:0xf1f1f1];
//    
//    CGPoint translation = CGPointMake(self.actionViewLeft.constant, self.actionViewTop.constant);
//    [self.actionViewPan setTranslation:translation inView:self.boundaryView];
    
    [TuneKit add:^{
        [TuneKit addRate:@"Colors per second" target:self keyPath:@"color" sampleInterval:2];
//        [TuneKit addSlider:@"TODO" target:self keyPath:@"dynamicsView.layer.cornerRadius" min:0 max:20];
        [TuneKit addColorPicker:@"Color" target:self keyPath:@"color"];
    } inPath:@[@"Dynamics Example"] sectionName:nil];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.boundaryView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TuneKit removePath:@[@"Dynamics Example"]];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
}

#pragma mark - Interaction

- (IBAction)actionViewPanned:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint translation = self.actionView.frame.origin;
            [sender setTranslation:translation inView:self.boundaryView];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [sender translationInView:self.boundaryView];
            self.actionViewLeft.constant = translation.x;
            self.actionViewTop.constant = translation.y;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [self impartVelocity:[sender velocityInView:self.boundaryView]];
        }
        default:
            break;
    }
}

- (void)impartVelocity:(CGPoint)velocity
{
    UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.actionView]];
    [behavior addLinearVelocity:velocity forItem:self.actionView];
    [self.animator addBehavior:behavior];
    __weak DynamicsViewController *weakSelf = self;
    __weak UIDynamicItemBehavior *weakBehavior = behavior;
    [behavior setAction:^{
        if (!CGRectIntersectsRect(weakSelf.boundaryView.bounds, weakSelf.actionView.frame)) {
            [weakSelf.animator removeBehavior:weakBehavior];
//            [weakSelf.boundaryView setNeedsLayout];
        }
    }];
}

@end
