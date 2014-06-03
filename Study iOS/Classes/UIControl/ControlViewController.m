//
//  ControlViewController.m
//  Study iOS
//
//  Created by juguanhui on 14-5-29.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import "ControlViewController.h"

@interface ControlViewController ()

@end

@implementation ControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_switch1 setEnabled:NO];
    
    [_slider setMinimumTrackTintColor:[UIColor redColor]];
    [_slider setMaximumTrackTintColor:[UIColor blackColor]];
    [_slider setThumbTintColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_switch1 release];
    [_slider release];
    [super dealloc];
}
@end
