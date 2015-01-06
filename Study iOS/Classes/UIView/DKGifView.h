//
//  DKGifView.h
//  DkReader
//
//  Created by juguanhui on 14-7-10.
//  Copyright (c) 2014年 Duokan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKGifViewDelegate <NSObject>

- (void)animationDidFinish:(BOOL)flag;

@end

@interface DKGifView : UIView

@property (nonatomic, assign) id <DKGifViewDelegate> delegate;
@property (nonatomic, copy) NSMutableArray *animationImages;
@property (nonatomic, copy) NSMutableArray *animationDuration;
@property (nonatomic, assign) NSInteger animationRepeatCount;
@property (nonatomic, assign) CGFloat totalTime;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

- (void)pauseAnimating;
- (void)resumeAnimating;

@end
