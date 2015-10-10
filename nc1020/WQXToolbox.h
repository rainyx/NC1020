//
//  WQXToolBox.h
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#define methodNotImplemented() mustOverride()

@interface WQXToolbox : NSObject

+ (CGRect)rectForCurrentOrientation:(CGRect)rect;
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;
+ (UIColor *)colorWithARGB:(NSUInteger)argb;
+ (UIColor *)colorWithRGBA:(NSUInteger)rgba;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIColor *)colorWithRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(NSInteger)a;
+ (NSString *)calcMD5Hash:(NSString *)string;

@end
