//
//  WQXLCDView.m
//  nc1020
//
//  Created by eric on 15/8/20.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXLCDView.h"
#import "nc1020.h"
#import <QuartzCore/QuartzCore.h>
#import "WQX.hpp"
#import "WQXToolbox.h"

#define LCD_WIDTH 160
#define LCD_HEIGHT 80
#define WQX_LCD_BUFF_SIZE 1600
#define IOS_LCD_BUFF_SIZE 1600*8

@implementation WQXLCDView
{
    uint8_t *_wqcLcdBuffer;
    uint8_t *_iosLcdBuffer;
    UIColor *_backgroundColor;
    UIColor *_foregroundColor;
    
    BOOL _needUpdate;
}

- (void)initVars {
    _wqcLcdBuffer = (uint8_t *)malloc(WQX_LCD_BUFF_SIZE);
    _iosLcdBuffer = (uint8_t *)malloc(IOS_LCD_BUFF_SIZE);
    
    _backgroundColor = kWQXLCDBackgroundColor;
    _foregroundColor = [UIColor blackColor];
}

- (id)init {
    if ([super init]) {
        [self initVars];
        return self;
    } else {
        return Nil;
    }
}

- (id)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initVars];
        
        
        return self;
    } else {
        return Nil;
    }
}

- (void) dealloc {
    free(_wqcLcdBuffer);
    free(_iosLcdBuffer);
    _wqcLcdBuffer = NULL;
    _iosLcdBuffer = NULL;
}

- (void)beginUpdate {
    _needUpdate = YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (!_needUpdate || !wqx::CopyLcdBuffer(_wqcLcdBuffer)) return;
    
    int index = 0;
    for (int i=0; i<WQX_LCD_BUFF_SIZE; i++) {
        uint8_t p = _wqcLcdBuffer[i];
        for (int j=0; j<8; j++) {
            _iosLcdBuffer[index++] = (uint8_t) ((p & (1 << (7 - j))) != 0 ? 0xFF : 0x00);
        }
    }
    
    // Erases first column pixels of the lcd buffer.
    for (int i=0; i<LCD_HEIGHT; i++) {
        _iosLcdBuffer[i*LCD_WIDTH] = 0;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [_backgroundColor setFill];
    CGContextSaveGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [[UIColor clearColor] CGColor]);
    CGContextFillRect(ctx, rect);
    
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetFillColorWithColor(ctx, [_backgroundColor CGColor]);
    CGContextFillRect(ctx, rect);
    CGContextRestoreGState(ctx);
    
    CGContextRef lcdCtx = CGBitmapContextCreate(_iosLcdBuffer, LCD_WIDTH, LCD_HEIGHT, 8, LCD_WIDTH, NULL, (CGBitmapInfo)kCGImageAlphaOnly);
    CGImageRef lcdImg = CGBitmapContextCreateImage(lcdCtx);
    
    // Keep pixels style.
    CGContextSetAllowsAntialiasing(ctx, false);
    CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    
    UIImage *lcdUIImg = [UIImage imageWithCGImage:lcdImg];
    [lcdUIImg drawInRect:CGRectMake(0, 0, rect.size.width-1, rect.size.height-1) blendMode:kCGBlendModeSourceOut alpha:1.0f];
    CGImageRelease(lcdImg);
    CGContextRelease(lcdCtx);
    
}
@end
