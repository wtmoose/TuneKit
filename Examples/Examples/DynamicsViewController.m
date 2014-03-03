//
//  DynamicsViewController.m
//  Examples
//
//  Created by Tim Moose on 3/2/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "DynamicsViewController.h"
#import <TuneKit/TuneKit.h>

@interface DynamicsViewController ()

@end

@implementation DynamicsViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [TuneKit add:^{
        [TuneKit addSlider:@"TODO" target:self keyPath:@"dynamicsView.layer.cornerRadius" min:0 max:20];
    } inPath:@[@"Dynamics Example"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TuneKit removePath:@[@"Dynamics Example"]];
}

@end
