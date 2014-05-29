//
//  DKSwitch.h
//  DkReader
//
//  Created by Wang Xiaolei on 5/23/13.
//  Copyright (c) 2013 Duokan Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

// 自定义Switch控件，接口和UISwitch类似
@interface PRESwitch : UIControl {
@private
    BOOL _on;
}

- (id)initWithFrame:(CGRect)frame;              // This class enforces a size appropriate for the control. The frame size is ignored.

@property(nonatomic,getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end
