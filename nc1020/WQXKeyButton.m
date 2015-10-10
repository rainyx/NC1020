//
//  WQXKeyButton.m
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXKeyButton.h"
#import "WQXToolbox.h"

@implementation WQXKeyButton

- (id)initWithFrame:(CGRect)frame andStyle:(WQXKeyButtonStyle)style {
    if ([super initWithFrame:frame]) {
        
        UIImage *bgImgNormal = [WQXToolbox imageWithColor:[WQXToolbox colorWithRGBA:0x404040FF]];
        UIImage *bgImgHighlighted = [WQXToolbox imageWithColor:[WQXToolbox colorWithRGBA:0xFFA800FF]];
        UIColor *labelColorNormal = [WQXToolbox colorWithRGBA:0xC5C5C5FF];
        UIColor *labelColorHighlighted = [UIColor blackColor];
        UIFont *labelFont = [UIFont systemFontOfSize:12.0f];
        
        switch (style) {
            case kWQXKeyButtonNormal:
                break;
            case kWQXKeyButtonFunction:
            case kWQXKeyButtonPrimary:
                bgImgNormal = [WQXToolbox imageWithColor:[WQXToolbox colorWithRGBA:0x5D5D5DFF]];
                labelFont = [UIFont fontWithName:@"Arial-BoldMT" size:12.0f];
                break;
            case kWQXKeyButtonNumber:
                bgImgNormal = [WQXToolbox imageWithColor:[WQXToolbox colorWithRGBA:0x737E92FF]];
                break;
            case kWQXKeyButtonSystem:
                bgImgNormal = [WQXToolbox imageWithColor:[WQXToolbox colorWithRGBA:0x574B3AFF]];
                break;
            default:
                break;
        }
        
        [self setBackgroundImage:bgImgNormal forState:UIControlStateNormal];
        [self setBackgroundImage:bgImgHighlighted forState:UIControlStateHighlighted];
        
        [self setTitleColor:labelColorNormal forState:UIControlStateNormal];
        [self setTitleColor:labelColorHighlighted forState:UIControlStateHighlighted];
        
        self.titleLabel.font = labelFont;
        
        return self;
    } else {
        return Nil;
    }
}

@end
