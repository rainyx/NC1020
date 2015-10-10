//
//  WQXKeyButton.h
//  nc1020
//
//  Created by rainyx on 15/8/22.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import <UIKit/UIKit.h>

enum WQXKeyButtonStyle {
    kWQXKeyButtonNormal,
    kWQXKeyButtonNumber,
    kWQXKeyButtonPrimary,
    kWQXKeyButtonSystem,
    kWQXKeyButtonFunction
};
typedef enum WQXKeyButtonStyle WQXKeyButtonStyle;

@interface WQXKeyButton : UIButton
- (id)initWithFrame:(CGRect)frame andStyle:(WQXKeyButtonStyle)style;
@end
