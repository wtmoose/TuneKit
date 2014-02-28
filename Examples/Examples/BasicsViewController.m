//
//  BasicsViewController.m
//  Examples
//
//  Created by Tim Moose on 2/25/14.
//  Copyright (c) 2014 Tractable Labs. All rights reserved.
//

#import "BasicsViewController.h"
#import <TuneKit/TuneKit.h>

@interface BasicsViewController ()
@property (strong, nonatomic) IBOutlet UIView *view1;
@end

@implementation BasicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [TuneKit enable];
    [TuneKit addColorPicker:@"View1 Color" target:self keyPath:@"view1.backgroundColor"];
    [TuneKit presentControlPanel];
}

@end
