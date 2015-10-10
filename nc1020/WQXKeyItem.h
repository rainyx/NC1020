//
//  WQXKeyItem.h
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQXKeyButton.h"

enum WQXCustomKeyCode {
    kWQXCustomKeyCodeBegin = 0x1000,
    kWQXCustomKeyCodeSave,
    kWQXCustomKeyCodeLoad,
    kWQXCustomKeyCodeSeppdup,
    kWQXCustomKeyCodeSpeedReset,
    kWQXCustomKeyCodeSwitch
};

typedef enum WQXCustomKeyCode WQXCustomKeyCode;

@interface WQXKeyItem : NSObject
{
    NSString *_title;
    NSInteger _keyCode;
    WQXKeyButtonStyle _buttonStyle;
}

@property(retain, nonatomic) NSString *title;
@property(nonatomic) NSInteger keyCode;
@property(nonatomic) WQXKeyButtonStyle buttonStyle;

- (id)initWithTitle:(NSString *)title andKeyCode:(NSInteger)keyCode andButtonStyle:(WQXKeyButtonStyle)style;

@end
