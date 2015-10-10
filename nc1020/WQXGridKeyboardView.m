//
//  WQXGridKeyboardView.m
//  NC1020
//
//  Created by rainyx on 15/8/23.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXGridKeyboardView.h"
#import "WQXKeyItem.h"
#import "WQXKeyButton.h"

@implementation WQXGridKeyboardView

- (id)initWithFrame:(CGRect)frame andRows:(NSMutableArray *)rows {
    
    if ([super initWithFrame:frame]) {
        
        NSInteger rowCount = rows.count;
        NSInteger colCount = [[rows objectAtIndex:0] count];
        
        CGFloat itemGap = 3.0f;
        CGFloat itemWidth = (frame.size.width - colCount * itemGap + itemGap) / colCount;
        CGFloat itemHeight = (frame.size.height - rowCount * itemGap + itemGap) / rowCount;
        
        CGFloat x, y = 0.0f;
        for (NSMutableArray *cols in rows) {
            x = 0.0f;
            for (WQXKeyItem *keyItem in cols) {
                WQXKeyButton *btn = [[WQXKeyButton alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight) andStyle:keyItem.buttonStyle];
                [btn setTitle:keyItem.title forState:UIControlStateNormal];
                [btn setTag:keyItem.keyCode];
                [btn addTarget:self action:@selector(didButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
                [btn addTarget:self action:@selector(didButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(didButtonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
                [self addSubview:btn];
                x += itemWidth + itemGap;
            }
            y += itemHeight + itemGap;
        }
        
        return self;
    } else {
        return Nil;
    }
    
}

@end
