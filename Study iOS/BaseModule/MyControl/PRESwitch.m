//
//  DKSwitch.m
//  DkReader
//
//  Created by Wang Xiaolei on 5/23/13.
//  Copyright (c) 2013 Duokan Technology. All rights reserved.
//

#import "PRESwitch.h"

#define SWITCH_CONTROL_WIDTH                66
#define SWITCH_CONTROL_HEIGHT               31
#define SWITCH_RECT_ON                      CGRectMake(0.0, 0.0, 108.0, 31.0)
#define SWITCH_RECT_OFF                     CGRectMake(-42.0, 0.0, 108.0, 31.0)

@interface PRESwitch ()
@property (nonatomic, retain) UIImageView *imgSwitchOnBg;
@property (nonatomic, retain) UIImageView *imgSwitchOffBg;
@property (nonatomic, retain) UIImageView *imgSwitchButton;
@end

@implementation PRESwitch

@synthesize imgSwitchOnBg;
@synthesize imgSwitchOffBg;
@synthesize imgSwitchButton;

- (id)initWithFrame:(CGRect)frame {
    // 固定宽高
    frame.size.width = SWITCH_CONTROL_WIDTH;
    frame.size.height = SWITCH_CONTROL_HEIGHT;
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}

- (void)awakeFromNib {
    // 固定宽高
    CGRect frame = self.frame;
    frame.size.width = SWITCH_CONTROL_WIDTH;
    frame.size.height = SWITCH_CONTROL_HEIGHT;
    self.frame = frame;
    
    [self initControls];
}

- (void)initControls {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgSwitchOnBg = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    imgSwitchOnBg.image = [UIImage imageNamed:@"switch_orangebg"];
    imgSwitchOnBg.alpha = 0;
    [self addSubview:imgSwitchOnBg];
    self.imgSwitchOffBg = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    imgSwitchOffBg.image = [UIImage imageNamed:@"switch_graybg"];
    [self addSubview:imgSwitchOffBg];
    self.imgSwitchButton = [[[UIImageView alloc] initWithFrame:SWITCH_RECT_OFF] autorelease];
    imgSwitchButton.image = [UIImage imageNamed:@"switch_rollbox"];
    [self addSubview:imgSwitchButton];
    
    _on = NO;
    [self updateSwitchState];
}

- (void)dealloc {
    self.imgSwitchOnBg = nil;
    self.imgSwitchOffBg = nil;
    self.imgSwitchButton = nil;
    
    [super dealloc];
}

- (BOOL)isOn {
    return _on;
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    if (on == _on) {
        return;
    }

    if (animated) {
        [UIView beginAnimations:nil context:nil];
    }
    _on = on;
    [self updateSwitchState];
    if (animated) {
        [UIView commitAnimations];
    }
}

- (void)updateSwitchState {
    imgSwitchOnBg.alpha = _on ? 1 : 0;
    imgSwitchOffBg.alpha = _on ? 0 : 1;
    imgSwitchButton.frame = _on ? SWITCH_RECT_ON : SWITCH_RECT_OFF;
}

- (void)onTouchUpInside:(id)sender {
    [self setOn:!_on animated:YES];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
