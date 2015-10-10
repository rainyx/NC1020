//
//  WQXKeyboardView.h
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WQXKeyboardView;

@protocol WQXKeyboardViewDelegate <NSObject>
@required
- (void)keyboardView:(WQXKeyboardView *)view didKeydown:(NSInteger)keyCode;
- (void)keyboardView:(WQXKeyboardView *)view didKeyup:(NSInteger)keyCode;
@end

@interface WQXKeyboardView : UIView
{
    __weak id<WQXKeyboardViewDelegate> _delegate;
}

@property(nonatomic, weak) id<WQXKeyboardViewDelegate> delegate;

- (void)didButtonTouchDown:(UIButton *)sender;
- (void)didButtonTouchUp:(UIButton *)sender;
@end
