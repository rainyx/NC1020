//
//  WQXKeyItem.m
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXKeyItem.h"

@implementation WQXKeyItem
@synthesize title = _title, keyCode = _keyCode, buttonStyle = _buttonStyle;

- (id)initWithTitle:(NSString *)title andKeyCode:(NSInteger)keyCode andButtonStyle:(WQXKeyButtonStyle)style {
    
    if ([self init]) {
        
        self.title = title;
        self.keyCode = keyCode;
        self.buttonStyle = style;
        return self;
    } else {
        return Nil;
    }
}

@end
