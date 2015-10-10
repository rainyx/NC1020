//
//  WQXToolBox.m
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXToolBox.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WQXToolbox

+ (NSString *)calcMD5Hash:(NSString *)string {
    // Create pointer to the string as UTF8
    const char *ptr = [string UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

+ (CGRect)rectForCurrentOrientation:(CGRect)rect {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    BOOL needFlip = NO;
    switch (orientation) {
        case UIInterfaceOrientationUnknown:
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            needFlip = rect.size.width > rect.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            needFlip = rect.size.height > rect.size.width;
            break;
        default:
            break;
    }
    
    CGRect ret = CGRectMake(rect.origin.x, rect.origin.y,
                            needFlip?rect.size.height:rect.size.width,
                            needFlip?rect.size.width:rect.size.height);
    
    return ret;
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb {
    return [WQXToolbox colorWithRed:(rgb>>16)&0xFF green:(rgb>>8)&0xFF blue:rgb&0xFF alpha:0xFF];
}

+ (UIColor *)colorWithARGB:(NSUInteger)argb {
    return [WQXToolbox colorWithRed:(argb>>16)&0xFF green:(argb>>8)&0xFF blue:argb&0xFF alpha:(argb>>24)&0xFF];
}

+ (UIColor *)colorWithRGBA:(NSUInteger)rgba {
    return [WQXToolbox colorWithRed:rgba>>24 green:(rgba>>16)&0xFF blue:(rgba>>8)&0xFF alpha:rgba&0xFF];
}

+ (UIColor *)colorWithRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(NSInteger)a {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
