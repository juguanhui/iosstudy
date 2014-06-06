//
//  MainViewController.h
//  Study iOS
//
//  Created by juguanhui on 14-5-29.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *toControl;
@property (retain, nonatomic) IBOutlet UIButton *toTransform;

- (IBAction)onControlClick:(id)sender;
- (IBAction)onTransformClick:(id)sender;

@end
