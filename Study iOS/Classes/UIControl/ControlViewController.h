//
//  ControlViewController.h
//  Study iOS
//
//  Created by juguanhui on 14-5-29.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlViewController : UIViewController
@property (retain, nonatomic) IBOutlet UISwitch *switch1;
@property (retain, nonatomic) IBOutlet UISlider *slider;
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;

@end
