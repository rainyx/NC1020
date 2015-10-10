//
//  WQXScreenLayout.m
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXDefaultScreenLayout.h"
#import "WQXKeyItem.h"
#import "WQXGridKeyboardView.h"

#define ADD_ITEM_TO_ROW(row, keyCode, title, style) [row addObject:[[WQXKeyItem alloc] initWithTitle:title andKeyCode:keyCode andButtonStyle:style]];

@interface WQXDefaultScreenLayout ()
{
    WQXLCDView *_lcdView;
    WQXKeyboardView *_leftKeyboardView;
    WQXKeyboardView *_rightKeyboardView;
    WQXKeyboardView *_mainKeyboardView;
}
@end

@implementation WQXDefaultScreenLayout

- (WQXLCDView *)lcdView {
    return _lcdView;
}

- (void)initViews {
    
    CGFloat padding = 5.0f;
    
    CGFloat lcdHeight = self.bounds.size.height / 2;
    CGFloat lcdWidth = lcdHeight * 2;
    CGFloat lcdX = self.bounds.size.width / 2 - lcdWidth / 2;
    CGFloat lcdY = padding;
    
    CGRect lcdFrame = CGRectMake(lcdX, lcdY, lcdWidth, lcdHeight);
    _lcdView = [[WQXLCDView alloc] initWithFrame:lcdFrame];
    
    CGFloat leftKeyboardWidth = (self.bounds.size.width - lcdWidth) / 2 - padding * 2;
    CGFloat leftKeyboardHeight = lcdHeight;
    CGFloat leftKeyboardX = padding;
    CGFloat leftKeyboardY = padding;
    
    CGRect leftKeyboardFrame = CGRectMake(leftKeyboardX, leftKeyboardY, leftKeyboardWidth, leftKeyboardHeight);
    _leftKeyboardView = [[WQXGridKeyboardView alloc] initWithFrame:leftKeyboardFrame andRows:[self createLeftKeyboardRows]];
    _leftKeyboardView.delegate = self;
    
    CGFloat rightKeyboardWidth = leftKeyboardWidth;
    CGFloat rightKeyboardHeight = leftKeyboardHeight;
    CGFloat rightKeyboardX = lcdX + lcdWidth + padding;
    CGFloat rightKeyboardY = padding;
    
    CGRect rightKeyboardFrame = CGRectMake(rightKeyboardX, rightKeyboardY, rightKeyboardWidth, rightKeyboardHeight);
    _rightKeyboardView = [[WQXGridKeyboardView alloc] initWithFrame:rightKeyboardFrame andRows:[self createRightKeyboardRows]];
    _rightKeyboardView.delegate = self;
    
    CGFloat mainKeyboardWidth = self.bounds.size.width - padding * 2;
    CGFloat mainKeyboardHeight = self.bounds.size.height - lcdHeight - padding * 3;
    CGFloat mainKeyboardX = padding;
    CGFloat mainKeyboardY = lcdHeight + padding * 2;
    
    CGRect mainKeyboardFrame = CGRectMake(mainKeyboardX, mainKeyboardY, mainKeyboardWidth, mainKeyboardHeight);
    _mainKeyboardView = [[WQXGridKeyboardView alloc] initWithFrame:mainKeyboardFrame andRows:[self createMainKeyboardRows]];
    _mainKeyboardView.delegate = self;
    
}

- (void) attachToView:(UIView *)view {
    [view addSubview:_lcdView];
    [view addSubview:_leftKeyboardView];
    [view addSubview:_rightKeyboardView];
    [view addSubview:_mainKeyboardView];
}

- (void) detachFromView:(UIView *)view {
    [_lcdView removeFromSuperview];
    [_leftKeyboardView removeFromSuperview];
    [_rightKeyboardView removeFromSuperview];
    [_mainKeyboardView removeFromSuperview];
}

- (NSMutableArray *) createMainKeyboardRows {
    NSMutableArray *row;
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    
    row = [[NSMutableArray alloc] init];
    
    ADD_ITEM_TO_ROW(row, 0x20, @"Q", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x21, @"W", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x22, @"E", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x23, @"R", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x24, @"T 7", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x25, @"Y 8", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x26, @"U 9", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x27, @"I", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x18, @"O", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x1C, @"P", kWQXKeyButtonNormal);
    
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    
    ADD_ITEM_TO_ROW(row, 0x28, @"A", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x29, @"S", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x2A, @"D", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x2B, @"F", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x2C, @"G 4", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x2D, @"H 5", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x2E, @"J 6", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x2F, @"K", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x19, @"L", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x1D, @"Enter", kWQXKeyButtonPrimary);
    
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    
    ADD_ITEM_TO_ROW(row, 0x30, @"Z", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x31, @"X", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x32, @"C", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x33, @"V", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x34, @"B 1", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x35, @"N 2", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x36, @"M 3", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x37, @"PgUp", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x1A, @"↑", kWQXKeyButtonPrimary);
    ADD_ITEM_TO_ROW(row, 0x1E, @"PgDn", kWQXKeyButtonNormal);
    
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    
    ADD_ITEM_TO_ROW(row, 0x38, @"Help", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x39, @"Shift", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x3A, @"Caps", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x3B, @"Esc", kWQXKeyButtonPrimary);
    ADD_ITEM_TO_ROW(row, 0x3C, @"0", kWQXKeyButtonNumber);
    ADD_ITEM_TO_ROW(row, 0x3D, @".", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x3E, @"=", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x3F, @"←", kWQXKeyButtonPrimary);
    ADD_ITEM_TO_ROW(row, 0x1B, @"↓", kWQXKeyButtonPrimary);
    ADD_ITEM_TO_ROW(row, 0x1F, @"→", kWQXKeyButtonPrimary);
    [rows addObject:row];
    
    return rows;
}

- (NSMutableArray *) createLeftKeyboardRows {
    
    NSMutableArray *row;
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, 0x0F, @"电源", kWQXKeyButtonSystem);
    ADD_ITEM_TO_ROW(row, 0x0B, @"英汉", kWQXKeyButtonFunction);
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, 0x0C, @"名片", kWQXKeyButtonFunction);
    ADD_ITEM_TO_ROW(row, 0x0D, @"计算", kWQXKeyButtonFunction);
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, 0x0A, @"行程", kWQXKeyButtonFunction);
    ADD_ITEM_TO_ROW(row, 0x09, @"测验", kWQXKeyButtonFunction);
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, 0x08, @"其他", kWQXKeyButtonFunction);
    ADD_ITEM_TO_ROW(row, 0x0E, @"网络", kWQXKeyButtonFunction);
    [rows addObject:row];
    
    return rows;
}

- (NSMutableArray *) createRightKeyboardRows {
    
    NSMutableArray *row;
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    
    row = [[NSMutableArray alloc] init];
    
    ADD_ITEM_TO_ROW(row, kWQXCustomKeyCodeSave, @"保存", kWQXKeyButtonSystem);
    //ADD_ITEM_TO_ROW(row, kWQXCustomKeyCodeLoad, @"加载", kWQXKeyButtonSystem);
    ADD_ITEM_TO_ROW(row, kWQXCustomKeyCodeSwitch, @"切换", kWQXKeyButtonSystem);
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, kWQXCustomKeyCodeSeppdup, @"加速", kWQXKeyButtonSystem);
    ADD_ITEM_TO_ROW(row, kWQXCustomKeyCodeSpeedReset, @"还原", kWQXKeyButtonSystem);
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, 0x10, @"F1", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x11, @"F2", kWQXKeyButtonNormal);
    [rows addObject:row];
    row = [[NSMutableArray alloc] init];
    ADD_ITEM_TO_ROW(row, 0x12, @"F3", kWQXKeyButtonNormal);
    ADD_ITEM_TO_ROW(row, 0x13, @"F4", kWQXKeyButtonNormal);
    [rows addObject:row];
    
    return rows;
}

@end
