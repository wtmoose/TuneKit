//
//  TKDialogViewController.m
//  TuneKit
//
//  Created by Tim Moose on 2/22/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "TKDialogViewController.h"
#import "TuneKit.h"
#import "TKDialogScrollView.h"
#import "NSObject+Utils.h"

@interface TKDialogViewController ()
@property (strong, nonatomic) TKDialogScrollView *scrollView;
@property (strong, nonatomic) UIView *containerView;

@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat shadowRadius;
@property (nonatomic) CGFloat shadowOpacity;
@property (nonatomic) CGFloat shadowYOffset;
@property (nonatomic) CGFloat decelerationRate;
@end

@implementation TKDialogViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TuneKit Dialog";
    self.view.tintColor = [UIColor colorWithHue:139.f/255.f saturation:202.f/255.f brightness:206.f/255.f alpha:1.f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.cornerRadius = 5.f;
    self.shadowRadius = 6.f;
    self.shadowOpacity = 0.15f;
    self.shadowYOffset = 4.f;
    self.decelerationRate = 0.6;

//    [TuneKit add:^{
//        [TuneKit addColorPicker:@"Tint Color" target:self keyPath:@"view.tintColor"];
//        [TuneKit addSlider:@"Corner Radius" target:self keyPath:@"cornerRadius" min:0 max:20];
//        [TuneKit addSlider:@"Shadow Radius" target:self keyPath:@"shadowRadius" min:0 max:10];
//        [TuneKit addSlider:@"Shadow Opacity" target:self keyPath:@"shadowOpacity" min:0 max:1];
//        [TuneKit addSlider:@"Shadow Y Offset" target:self keyPath:@"shadowYOffset" min:-5 max:5];
//        [TuneKit addSlider:@"Deceleration Rate" target:self keyPath:@"decelerationRate" min:UIScrollViewDecelerationRateFast * 0.1 max:UIScrollViewDecelerationRateFast * 1.5];
//    } inPath:[TuneKit pathForViewController:self] sectionName:nil];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [TuneKit removePath:[TuneKit pathForViewController:self]];
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
    //TODO This most certainly won't work with device rotation
    
    static CGFloat width = 280.f;
    
    UIView *rootView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    self.scrollView = [[TKDialogScrollView alloc] initWithFrame:rootView.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [rootView addSubview:self.scrollView];

    CGFloat padding = 10.f;
    
    // nest our view in a container view for styling purposes
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    CGSize rootSize = rootView.bounds.size;
    CGSize containerSize = CGSizeMake(width, self.scrollView.bounds.size.height - 2.f * padding);
    self.scrollView.contentSize = CGSizeMake(rootSize.width * 2.f - containerSize.width - 2.f * padding, rootSize.height * 2.f - containerSize.height - 2.f * padding + 1.f);
    CGRect containerFrame = CGRectMake(self.scrollView.contentSize.width / 2.f - containerSize.width / 2.f, self.scrollView.contentSize.height / 2.f - containerSize.height / 2.f, containerSize.width, containerSize.height);
    self.containerView.frame = containerFrame;
    self.scrollView.contentOffset = CGPointMake(containerFrame.origin.x - leftOrigin, 0.f);
    [self.scrollView addSubview:self.containerView];
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast * self.decelerationRate;
    
    self.view.frame = self.containerView.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    [self.containerView addSubview:self.view];
}

- (IBAction)dismiss {
    [self.containerView removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self themeViewController:self];
}

- (void)setDecelerationRate:(CGFloat)decelerationRate
{
    _decelerationRate = decelerationRate;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast * self.decelerationRate;
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
