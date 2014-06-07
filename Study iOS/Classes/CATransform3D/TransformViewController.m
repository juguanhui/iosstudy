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

@synthesize bottomView;
@synthesize topView;

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
    UIView *leftView = [[UIView alloc] initWithFrame:rcLeft];
    leftView.backgroundColor = [UIColor blueColor];
    [self.view insertSubview:leftView atIndex:0];
    [leftView release];
    
    UIView *rightView = [[UIView alloc] initWithFrame:rcRight];
    rightView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:rightView atIndex:0];
    [rightView release];
    
    bottomView.layer.zPosition = leftView.layer.zPosition + rightView.layer.zPosition + 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [bottomView release];
    [topView release];
    [super dealloc];
}

- (IBAction)onOpenClick:(id)sender {
    const CGFloat M34Transform = -0.0004;   // 透视效果
    
    CGPoint ptTopBegin =  CGPointMake(rcBegin.origin.x + rcBegin.size.width / 2,
                                      rcBegin.origin.y + rcBegin.size.height / 2);
    CGPoint scaleTopBegin = CGPointMake(1, 1);
    CATransform3D transLeft = CATransform3DIdentity;
    transLeft = CATransform3DScale(transLeft, scaleTopBegin.x, scaleTopBegin.y, 1);
    topView.layer.transform = transLeft;
    topView.layer.position = ptTopBegin;
    
    CGPoint ptBottomBegin = CGPointMake(rcBegin.origin.x + rcBegin.size.width,
                                       rcBegin.origin.y + rcBegin.size.height / 2);
    CGPoint scaleBottomBegin = CGPointMake(1, 1);
    CATransform3D transBottom = CATransform3DIdentity;
    transBottom.m34 = M34Transform;
    transBottom = CATransform3DRotate(transBottom, M_PI_2, 0, 1, 0);
    transBottom = CATransform3DScale(transBottom, scaleBottomBegin.x, scaleBottomBegin.y, 1);
    bottomView.layer.transform = transBottom;
    bottomView.layer.anchorPoint = CGPointMake(0, 0.5);
    bottomView.layer.position = ptBottomBegin;
    bottomView.layer.doubleSided = NO;
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         CGPoint ptTopEnd =  CGPointMake(rcLeft.origin.x + rcLeft.size.width / 2,
                                                         rcLeft.origin.y + rcLeft.size.height / 2);
                         CGPoint scaleTopEnd = CGPointMake(rcLeft.size.width / rcBegin.size.width,
                                                            rcLeft.size.height / rcBegin.size.height);
                         CATransform3D transLeft = CATransform3DIdentity;
                         transLeft = CATransform3DScale(transLeft, scaleTopEnd.x, scaleTopEnd.y, 1);
                         topView.layer.transform = transLeft;
                         topView.layer.position = ptTopEnd;
                         
                         CGPoint ptRightEnd = CGPointMake(rcRight.origin.x,
                                                          rcRight.origin.y + rcRight.size.height / 2);
                         CGPoint scaleBottomEnd = CGPointMake(rcRight.size.width / rcBegin.size.width,
                                                              rcRight.size.height / rcBegin.size.height);
                         CATransform3D transBottom = CATransform3DIdentity;
                         transBottom.m34 = M34Transform;
                         transBottom = CATransform3DScale(transBottom, scaleBottomEnd.x, scaleBottomEnd.y, 1);
                         bottomView.layer.transform = transBottom;
                         bottomView.layer.position = ptRightEnd;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)onCloseClick:(id)sender {
    const CGFloat M34Transform = -0.0004;   // 透视效果
    CGPoint ptRightEnd = CGPointMake(rcRight.origin.x,
                                     rcRight.origin.y + rcRight.size.height / 2);
    CGPoint scaleBottomEnd = CGPointMake(rcRight.size.width / rcBegin.size.width,
                                         rcRight.size.height / rcBegin.size.height);
    CATransform3D transBottom = CATransform3DIdentity;
    transBottom.m34 = M34Transform;
    transBottom = CATransform3DScale(transBottom, scaleBottomEnd.x, scaleBottomEnd.y, 1);
    bottomView.layer.transform = transBottom;
    bottomView.layer.position = ptRightEnd;
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         CGPoint ptTopBegin =  CGPointMake(rcBegin.origin.x + rcBegin.size.width / 2,
                                                           rcBegin.origin.y + rcBegin.size.height / 2);
                         CGPoint scaleLeftBegin = CGPointMake(1, 1);
                         CATransform3D transLeft = CATransform3DIdentity;
                         transLeft = CATransform3DScale(transLeft, scaleLeftBegin.x, scaleLeftBegin.y, 1);
                         topView.layer.transform = transLeft;
                         topView.layer.position = ptTopBegin;
                         
                         CGPoint ptBottomBegin = CGPointMake(rcBegin.origin.x + rcBegin.size.width,
                                                             rcBegin.origin.y + rcBegin.size.height / 2);
                         CGPoint scaleBottomBegin = CGPointMake(1, 1);
                         CATransform3D transBottom = CATransform3DIdentity;
                         transBottom.m34 = M34Transform;
                         transBottom = CATransform3DRotate(transBottom, M_PI_2, 0, 1, 0);
                         transBottom = CATransform3DScale(transBottom, scaleBottomBegin.x, scaleBottomBegin.y, 1);
                         bottomView.layer.transform = transBottom;
                         bottomView.layer.anchorPoint = CGPointMake(0, 0.5);
                         bottomView.layer.position = ptBottomBegin;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
@end
