//
//  WQXKeyboardView.m
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXKeyboardView.h"
#import "WQXKeyItem.h"
#import "WQXKeyButton.h"

@implementation WQXKeyboardView
@synthesize delegate = _delegate;

- (void) didButtonTouchDown:(UIButton *)sender {
    if (self.delegate != Nil && [self.delegate respondsToSelector:@selector(keyboardView:didKeydown:)]) {
        [self.delegate keyboardView:self didKeydown:sender.tag];
    }
}
- (void) didButtonTouchUp:(UIButton *)sender {
    if (self.delegate != Nil && [self.delegate respondsToSelector:@selector(keyboardView:didKeyup:)]) {
        [self.delegate keyboardView:self didKeyup:sender.tag];
    }
}


@end
