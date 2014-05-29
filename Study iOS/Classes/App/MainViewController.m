//
//  MainViewController.m
//  Study iOS
//
//  Created by juguanhui on 14-5-29.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import "MainViewController.h"
#import "ControlViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    [self.toControl setBackgroundColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_toControl release];
    [super dealloc];
}

- (IBAction)onControlClick:(id)sender {
    ControlViewController* controlViewController = [[ControlViewController alloc] initWithNibName:@"ControlViewController" bundle:nil];
    [self.navigationController pushViewController:controlViewController animated:YES];
    [controlViewController release];
}

@end
