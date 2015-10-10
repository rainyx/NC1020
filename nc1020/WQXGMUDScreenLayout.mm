//
//  WQXGMUDScreenLayout.m
//  NC1020
//
//  Created by rainyx on 15/8/23.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXGMUDScreenLayout.h"
#import "WQX.hpp"
#import "WQXGMUDKeyboardView.h"
#define isDirectionKeyCode(code) ((code==0x1A||code==0x1B||code==0x3F||code==0x1F))

@interface WQXGMUDScreenLayout ()
{
    UIView *_rootView;
    WQXLCDView *_lcdView;
    WQXGMUDKeyboardView *_keyboardView;
}
@end

@implementation WQXGMUDScreenLayout

- (void)initViews {
    
    _rootView = [[UIView alloc] initWithFrame:self.bounds];
    _rootView.backgroundColor = kWQXLCDBackgroundColor;
    
    CGFloat lcdWidth = _rootView.bounds.size.width;
    CGFloat lcdHeight = lcdWidth/2;
    CGFloat lcdX = _rootView.bounds.size.width / 2 - lcdWidth / 2;
    CGFloat lcdY = _rootView.bounds.size.height / 2 - lcdHeight / 2;
    
    _lcdView = [[WQXLCDView alloc] initWithFrame:CGRectMake(lcdX, lcdY, lcdWidth, lcdHeight)];
    
    CGFloat keyboardViewWidth = _rootView.bounds.size.width;
    CGFloat keyboardViewHeight = _rootView.bounds.size.height / 2;
    CGFloat keyboardViewX = 0.0f;
    CGFloat keyboardViewY = _rootView.bounds.size.height - keyboardViewHeight;
    
    _keyboardView = [[WQXGMUDKeyboardView alloc] initWithFrame:CGRectMake(keyboardViewX, keyboardViewY, keyboardViewWidth, keyboardViewHeight)];
    _keyboardView.delegate = self;
    
    [_rootView addSubview:_lcdView];
    [_rootView addSubview:_keyboardView];
}
// Makes speed up for direction buttons.
- (void)keyboardView:(WQXKeyboardView *)view didKeydown:(NSInteger)keyCode {
    if (self.keyboardViewDelegate != Nil && [self.keyboardViewDelegate respondsToSelector:@selector(keyboardView:didKeydown:)]) {
        if (isDirectionKeyCode(keyCode)) {
            [self.keyboardViewDelegate keyboardView:view didKeydown:0x30];
        }
        [self.keyboardViewDelegate keyboardView:view didKeydown:keyCode];
    }
}
// Resets speed for direction buttons.
- (void)keyboardView:(WQXKeyboardView *)view didKeyup:(NSInteger)keyCode {
    if (self.keyboardViewDelegate != Nil && [self.keyboardViewDelegate respondsToSelector:@selector(keyboardView:didKeyup:)]) {
        if (isDirectionKeyCode(keyCode)) {
            [self.keyboardViewDelegate keyboardView:view didKeyup:0x30];
        }
        [self.keyboardViewDelegate keyboardView:view didKeyup:keyCode];
    }
}

- (WQXLCDView *)lcdView {
    return _lcdView;
}

- (void)attachToView:(UIView *)view {
    [view addSubview:_rootView];
}

- (void) detachFromView:(UIView *)view {
    [_rootView removeFromSuperview];
}

@end
