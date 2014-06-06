//
//  TransformViewController.m
//  Study iOS
//
//  Created by juguanhui on 14-6-6.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@property (nonatomic, assign) CGRect rcBegin;
@property (nonatomic, assign) CGRect rcLeft;
@property (nonatomic, assign) CGRect rcRight;

@end

@implementation TransformViewController

@synthesize rcBegin;
@synthesize rcLeft;
@synthesize rcRight;

@synthesize leftView;
@synthesize rightView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        rcBegin = CGRectMake(200, 200, 100, 100);
        rcLeft = CGRectMake(400, 400, 200, 200);
        rcRight = CGRectMake(600, 400, 200, 200);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [leftView release];
    [rightView release];
    [super dealloc];
}

- (IBAction)onOpenClick:(id)sender {
    [self.view bringSubviewToFront:leftView];
    
    CGPoint ptBegin =  CGPointMake(rcBegin.origin.x,
                                   rcBegin.origin.y + rcBegin.size.height / 2);
    CGPoint ptLeftEnd =  CGPointMake(rcLeft.origin.x,
                                     rcLeft.origin.y + rcLeft.size.height / 2);
    
    CGPoint scaleLeftEnd = CGPointMake(rcLeft.size.width / rcBegin.size.width,
                                         rcLeft.size.height / rcBegin.size.height);
    CGPoint scaleLeftBegin = CGPointMake(1, 1);
    
    CATransform3D transLeft = CATransform3DIdentity;
    transLeft = CATransform3DScale(transLeft, scaleLeftBegin.x, scaleLeftBegin.y, 1);
    leftView.layer.transform = transLeft;
    leftView.layer.position = ptBegin;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         CATransform3D transLeft = CATransform3DIdentity;
                         transLeft = CATransform3DScale(transLeft, scaleLeftEnd.x, scaleLeftEnd.y, 1);
                         leftView.layer.transform = transLeft;
                         leftView.layer.position = ptLeftEnd;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)onCloseClick:(id)sender {
    
    rightView.frame = rcBegin;
    leftView.frame = rcBegin;
}
@end
