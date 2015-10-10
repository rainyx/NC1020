//
//  WQXKeyCircleButton.m
//  NC1020
//
//  Created by rainyx on 15/8/23.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXKeyCircleButton.h"
#import "WQXToolbox.h"

@interface WQXKeyCircleButton ()
{
    
}
@end

@implementation WQXKeyCircleButton

- (id)initWithOrigin:(CGPoint)origin andRadius:(CGFloat)radius {
    
    CGRect rect = CGRectMake(origin.x, origin.y, radius*2, radius*2);
    if ([super initWithFrame:rect]) {
        
        self.layer.cornerRadius = radius;
        self.alpha = 0.3f;
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        return self;
    } else {
        return Nil;
    }
}

@end
