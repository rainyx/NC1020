//
//  WQXScreenLayout.h
//  NC1020
//
//  Created by rainyx on 15/8/23.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WQXKeyboardView.h"
#import "WQXLCDView.h"

@interface WQXScreenLayout : NSObject<WQXKeyboardViewDelegate>

@property(weak, nonatomic) id<WQXKeyboardViewDelegate> keyboardViewDelegate;
@property(nonatomic) CGRect bounds;

- (id)initWithBounds:(CGRect)bounds andKeyboardViewDelegate:(id<WQXKeyboardViewDelegate>)delegate;
- (WQXLCDView *)lcdView;
- (void) attachToView:(UIView *)view;
- (void) detachFromView:(UIView *)view;

- (void)initViews;

@end
