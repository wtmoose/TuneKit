//
//  TKDialogViewController.m
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKDialogViewController.h"
#import "TuneKit.h"

@interface TKDialogViewController ()
@property (weak, nonatomic) UIView *containerView;
@property (weak, nonatomic) NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) UIPanGestureRecognizer *panNavigationBar;

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat shadowRadius;
@property (nonatomic) CGFloat shadowOpacity;
@property (nonatomic) CGFloat shadowYOffset;

@end

@implementation TKDialogViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.panNavigationBar = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panNavigationBar:)];
    [self.navigationBar addGestureRecognizer:self.panNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.cornerRadius = 5.f;
    self.shadowRadius = 6.f;
    self.shadowOpacity = 0.15f;
    self.shadowYOffset = 4.f;

//    [TuneKit add:^{
//        
//        [TuneKit addSlider:@"Corner Radius" target:self keyPath:@"cornerRadius" min:0 max:20];
//        [TuneKit addSlider:@"Shadow Radius" target:self keyPath:@"shadowRadius" min:0 max:10];
//        [TuneKit addSlider:@"Shadow Opacity" target:self keyPath:@"shadowOpacity" min:0 max:1];
//        [TuneKit addSlider:@"Shadow Y Offset" target:self keyPath:@"shadowYOffset" min:-5 max:5];
//        
//    } inPath:@[@"TuneKit Control Panel"]];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    [TuneKit removePath:@[@"TuneKit Control Panel"]];
//}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    [self.dismissButton addTarget:self action:@selector(dismiss)
//                 forControlEvents:UIControlEventTouchUpInside];
//}

//#pragma mark - Content
//
//- (void)setContentViewController:(UIViewController *)contentViewController
//{
//    [self view];
//    [_contentViewController removeFromParentViewController];
//    [_contentViewController.view removeFromSuperview];
//    _contentViewController = contentViewController;
//    [self addChildViewController:contentViewController];
//    contentViewController.view.frame = self.contentView.bounds;
//    contentViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
//    contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.contentView addSubview:contentViewController.view];
//}

#pragma mark - Presenting

- (void)presentAtLeftOrigin:(CGFloat)leftOrigin
{
    static CGFloat width = 280.f;
    
    // nest our view in a container view for styling purposes
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *parentView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    self.containerView = view;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [parentView addSubview:view];
    [view addSubview:self.view];

    // setup constraints for managing the container view's frame
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:parentView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:20.f];
    self.leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:parentView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:leftOrigin];
    
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:parentView
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view
                                                      attribute:NSLayoutAttributeBottom
                                                     multiplier:1.f
                                                       constant:20.f];

//    NSArray *horizontalBoundaries = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[view]-(>=20)-|"
//                                                                            options:0
//                                                                            metrics:nil
//                                                                              views:@{@"view" : view}];
//
//    NSArray *verticalBoundaries = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[view]-(>=20)-|"
//                                                                          options:0 metrics:nil
//                                                                            views:@{@"view" : view}];

    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(width)]"
                                                                        options:0
                                                                        metrics:@{@"width" : @(width)}
                                                                          views:@{@"view" : view}];

    [parentView addConstraints:@[self.topConstraint, self.leftConstraint, self.bottomConstraint]];
//    [parentView addConstraints:horizontalBoundaries];
//    [parentView addConstraints:verticalBoundaries];
    [view addConstraints:widthConstraints];
    
    [view layoutIfNeeded];
}

- (IBAction)dismiss {
    [self.containerView removeFromSuperview];
    [self removeFromParentViewController];
    self.topConstraint = nil;
    self.leftConstraint = nil;
    self.bottomConstraint = nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self themeViewController:self];
}

#pragma mark - Moving

- (void)panNavigationBar:(UIGestureRecognizer *)recognizer
{
    UIView *parentView = [self.containerView superview];
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)recognizer;
    CGPoint translation = [pan translationInView:parentView];
    CGFloat constant = self.leftConstraint.constant + translation.x;
    if (constant >= 0.f && constant + self.containerView.bounds.size.width <= parentView.bounds.size.width - 0.f) {
        self.leftConstraint.constant = constant;
    }
    [pan setTranslation:CGPointZero inView:parentView];
}

#pragma mark - Theme

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self themeViewController:self];
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    _shadowRadius = shadowRadius;
    [self themeViewController:self];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    _shadowOpacity = shadowOpacity;
    [self themeViewController:self];
}

- (void)setShadowYOffset:(CGFloat)shadowYOffset
{
    _shadowYOffset = shadowYOffset;
    [self themeViewController:self];
}

- (void)themeViewController:(TKDialogViewController *)controller
{
    controller.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *contentLayer = self.view.layer;
    contentLayer.cornerRadius = self.cornerRadius;
    contentLayer.borderColor = [UIColor colorWithWhite:0.75 alpha:1].CGColor;
    contentLayer.borderWidth = 1;
    contentLayer.masksToBounds = YES;
    
    CALayer *layer = self.containerView.layer;
    layer.cornerRadius = self.cornerRadius;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    layer.shadowOffset = CGSizeMake(0.f, self.shadowYOffset);
    layer.shadowOpacity = self.shadowOpacity;
    layer.shadowRadius = self.shadowRadius;
    layer.shadowPath = CGPathCreateWithRoundedRect(layer.bounds, self.cornerRadius, self.cornerRadius, NULL);
}

@end
