//
//  TransformViewController.h
//  Study iOS
//
//  Created by juguanhui on 14-6-6.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransformViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *bottomView;
@property (retain, nonatomic) IBOutlet UIImageView *topView;
- (IBAction)onOpenClick:(id)sender;
- (IBAction)onCloseClick:(id)sender;

@end
