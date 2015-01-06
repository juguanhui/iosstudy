//
//  DKGifView.m
//  DkReader
//
//  Created by juguanhui on 14-7-10.
//  Copyright (c) 2014年 Duokan Technology. All rights reserved.
//

#import "DKGifView.h"

@interface DKGifView()

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isPaused;

@end

@implementation DKGifView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.animationRepeatCount = 0;
        self.isAnimating = NO;
        self.isPaused = NO;
    }
    return self;
}

- (void)dealloc {
    [_animationImages removeAllObjects];
    [_animationDuration removeAllObjects];
    [super dealloc];
}

- (void)startAnimating {
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    int count = MIN(_animationDuration.count, _animationImages.count);
    
    NSMutableArray *times = [NSMutableArray arrayWithCapacity:count];
    CGFloat currentTime = 0;
    for (int i = 0; i < count; ++i) {
        [times addObject:[NSNumber numberWithFloat:(currentTime / _totalTime)]];
        currentTime += [[_animationDuration objectAtIndex:i] floatValue];
    }
    [animation setKeyTimes:times];
    [animation setValues:_animationImages];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = _totalTime;
    animation.delegate = self;
    animation.repeatCount = _animationRepeatCount;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.layer addAnimation:animation forKey:@"gifAnimation"];
    self.isAnimating = YES;
    self.isPaused = NO;
}

- (void)stopAnimating {
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    self.layer.contents = nil;
    [self.layer removeAllAnimations];
    self.isAnimating = NO;
    self.isPaused = NO;
}

- (BOOL)isAnimating {
    return _isAnimating;
}

- (void)pauseAnimating {
    if (self.isPaused) {
        return ;
    }
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
    self.isAnimating = NO;
    self.isPaused = YES;
}

- (void)resumeAnimating {
    if (self.isPaused) {
        CFTimeInterval pausedTime = self.layer.timeOffset;
        self.layer.speed = 1.0;
        self.layer.timeOffset = 0.0;
        CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.layer.beginTime = timeSincePause;
        self.isAnimating = YES;
        self.isPaused = NO;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop start flag = %d", flag);
    if (flag) {
        self.layer.contents = nil;
        [self.layer removeAllAnimations];
    }
    [self.delegate animationDidFinish:flag];
}

- (void)setAnimationRepeatCount:(NSInteger)repeatCount {
    _animationRepeatCount = (repeatCount <= 0) ? 100000 : repeatCount;
}

@end
