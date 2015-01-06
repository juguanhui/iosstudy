//
//  CustomViewController.m
//  Study iOS
//
//  Created by juguanhui on 14-6-4.
//  Copyright (c) 2014年 juguanhui. All rights reserved.
//

#import "CustomViewController.h"
#import "DKGifView.h"

@interface CustomViewController () {
	dispatch_queue_t createImageQueue;
    id threadLock;
}

@property (nonatomic, retain) NSDictionary * curGifInfo;
@property (retain, nonatomic) DKGifView *gifView;
@property (retain, nonatomic) UIButton *btnPush;

- (void)onBtnClick:(id)sender;

@end

@implementation CustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        createImageQueue = dispatch_queue_create("createImageQueue", NULL);
        threadLock = [[NSObject alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DKGifView *tmpGifView = [[DKGifView alloc] initWithFrame:CGRectMake(200, 200, 300, 300)];
    self.gifView = tmpGifView;
    self.gifView.delegate = self;
    [self.view addSubview:tmpGifView];
    [tmpGifView release];
    
    UIButton *tmpBtnPush = [[UIButton alloc] initWithFrame:CGRectMake(200, 650, 300, 50)];
    [tmpBtnPush setTitle:@"push" forState:UIControlStateNormal];
    [tmpBtnPush setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tmpBtnPush setBackgroundColor:[UIColor grayColor]];
    self.btnPush = tmpBtnPush;
    [tmpBtnPush addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tmpBtnPush];
    [tmpBtnPush release];
    
    [self resetGifInfoAsync];
    dispatch_sync(createImageQueue, ^{
        [self setGifToView];
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onBtnClick:(id)sender {
    TransformViewController* viewController = [[TransformViewController alloc] initWithNibName:@"TransformViewController" bundle:nil];
    viewController.delegate = self;
//    [self.navigationController pushViewController:viewController animated:YES];
    [self presentViewController:viewController animated:YES completion:nil];
    [viewController release];
}

- (void)dealloc {
    [self.gifView stopAnimating];
    
    //clear images
    self.gifView.animationImages = nil;
    self.gifView.animationDuration = nil;
    self.gifView.totalTime = 0;
    self.gifView.animationRepeatCount = 1;
    dispatch_sync(createImageQueue, ^{
    });
    
    dispatch_release(createImageQueue);
    self.curGifInfo = nil;
    [_gifView release];
    [threadLock release];
    [_btnPush release];
    [super dealloc];
}

- (void)resetGifInfoAsync {
    dispatch_async(createImageQueue, ^{
        @synchronized(threadLock) {
            if (self.curGifInfo) {
                return;
            }
            self.curGifInfo = nil;
            NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:1];
            if (imageArray) {
                NSMutableArray *durationSeconds = [NSMutableArray arrayWithCapacity:1];
                if (durationSeconds) {
                    CGFloat totalTime = 0.0;
                    for (int i = 0; i < 20; i++) {
                        CGFloat curDuration = 0.1;
                        [durationSeconds addObject:[NSNumber numberWithFloat:curDuration]];
                        totalTime += curDuration;
                        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
                        if (image) {
                            [imageArray addObject:(id)image.CGImage];
                        }
                    }
                    self.curGifInfo = [NSDictionary dictionaryWithObjectsAndKeys:imageArray, @"images",
                                       durationSeconds, @"duration",
                                       [NSNumber numberWithFloat:totalTime], @"totaltime", nil];
                }
            }
        }
    });
}

- (void)setGifToView {
    @synchronized(threadLock) {
        [self.gifView setAnimationImages:[_curGifInfo objectForKey:@"images"]];
        [self.gifView setAnimationDuration:[_curGifInfo objectForKey:@"duration"]];
        [self.gifView setTotalTime:[[_curGifInfo objectForKey:@"totaltime"] floatValue]];
        [self.gifView setAnimationRepeatCount:1];
        [self.gifView startAnimating];
        [self resetGifInfoAsync];
    }
}

- (void)onViewCloseClick {
    [self dismissViewControllerAnimated:YES completion:^{
        [self setGifToView];
    }];
}

- (void)animationDidFinish:(BOOL)flag {
    NSLog(@"self.layer = %@", self.view.layer);
    NSLog(@"self.sublayer = %@", self.view.layer.sublayers);
    NSLog(@"self.gifView.layer = %@", self.gifView.layer);
    NSLog(@"self.gifView.sublayer = %@", self.gifView.layer.sublayers);
    NSLog(@"-------------");
    if (flag) {
        [self setGifToView];
    } else {
    }
}

@end
