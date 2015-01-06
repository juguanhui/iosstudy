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
    
    [_segment setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_segment setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [_segment insertSegmentWithTitle:@"3" atIndex:2 animated:NO];
    
    [_pickerView reloadAllComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_switch1 release];
    [_slider release];
    [_datePicker release];
    [_segment release];
    [_pickerView release];
    [super dealloc];
}

#pragma mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 2;
    } else {
        return 3;
    }
}

#pragma mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 200;
    }
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (component == 0) {
//        return [NSString stringWithFormat:@"comp%d", row];
//    } else {
//        return [NSString stringWithFormat:@"nent%d", row];
//    }
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *myView = nil;
    if (component == 0) {
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)] autorelease];
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        myView.text = [NSString stringWithFormat:@"comp%d", row];
        myView.backgroundColor = [UIColor clearColor];
    }else {
        myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)] autorelease];
        myView.font = [UIFont systemFontOfSize:14];
        myView.text = [NSString stringWithFormat:@"nent%d", row];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    
//}

@end
