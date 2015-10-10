//
//  WQXGMUDKeyboardView.m
//  NC1020
//
//  Created by rainyx on 15/8/23.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQXGMUDKeyboardView.h"
#import "WQXKeyCircleButton.h"
#import "WQXKeyItem.h"
#import <QuartzCore/QuartzCore.h>
#import "WQXToolbox.h"

@implementation WQXGMUDKeyboardView

- (id)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        ////////////////////////////////////////////////////////////////////////////////////
        // Creates left buttons.
        ////////////////////////////////////////////////////////////////////////////////////
        
        CGFloat leftPanelItemWidth = 55.0f;
        CGFloat leftPanelItemGap = -10.0f;
        CGFloat leftPanelMargin = 10.0f;
        CGFloat leftPanelWidth = (leftPanelItemWidth + leftPanelItemGap) * 3 - leftPanelItemGap;
        CGFloat leftPanelItemFullWidth = leftPanelItemWidth + leftPanelItemGap;
        
        UIView *leftPanel = [[UIView alloc] initWithFrame:CGRectMake(leftPanelMargin, frame.size.height - (leftPanelWidth+leftPanelMargin), leftPanelWidth, leftPanelWidth)];
        
        WQXKeyCircleButton *upButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(leftPanelItemFullWidth, 0) andRadius:leftPanelItemWidth/2];
        WQXKeyCircleButton *downButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(leftPanelItemFullWidth, leftPanelItemFullWidth*2) andRadius:leftPanelItemWidth/2];
        WQXKeyCircleButton *leftButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(0, leftPanelItemFullWidth) andRadius:leftPanelItemWidth/2];
        WQXKeyCircleButton *rightButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(leftPanelItemFullWidth*2, leftPanelItemFullWidth) andRadius:leftPanelItemWidth/2];
        
        [upButton setTitle:@"上" forState:UIControlStateNormal];
        [downButton setTitle:@"下" forState:UIControlStateNormal];
        [leftButton setTitle:@"左" forState:UIControlStateNormal];
        [rightButton setTitle:@"右" forState:UIControlStateNormal];
        
        upButton.tag = 0x1A;
        downButton.tag = 0x1B;
        leftButton.tag = 0x3F;
        rightButton.tag = 0x1F;
        
        [leftPanel addSubview:upButton];
        [leftPanel addSubview:downButton];
        [leftPanel addSubview:leftButton];
        [leftPanel addSubview:rightButton];
        
        ////////////////////////////////////////////////////////////////////////////////////
        // Creates right buttons.
        ////////////////////////////////////////////////////////////////////////////////////
        CGFloat rightPanelItemWidth = 50.0f;
        CGFloat rightPanelItemGap = 8.0f;
        CGFloat rightPanelMargin = 10.0f;
        CGFloat rightPanelItemFullWidth = rightPanelItemWidth + rightPanelItemGap;
        CGFloat rightPanelWidth = rightPanelItemFullWidth * 4 - rightPanelItemGap;
        CGFloat rightPanelHeight = rightPanelItemFullWidth * 2 - rightPanelItemGap;
        CGFloat rightPanelLine1Indent = -(rightPanelItemFullWidth/2);
        CGFloat rightPanelItemMarginTop = -10.0f;
       
        CGFloat rightPanelX = frame.size.width - (rightPanelWidth + rightPanelLine1Indent + rightPanelMargin);
        CGFloat rightPanelY = frame.size.height - (rightPanelHeight  + rightPanelMargin);
        
        UIView *rightPanel = [[UIView alloc] initWithFrame:CGRectMake(rightPanelX, rightPanelY, rightPanelWidth, rightPanelHeight)];
        
        // Line 1.
        WQXKeyCircleButton *backButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(rightPanelItemFullWidth+rightPanelLine1Indent, 0) andRadius:rightPanelItemWidth/2];
        WQXKeyCircleButton *flyButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(rightPanelItemFullWidth*2+rightPanelLine1Indent, rightPanelItemMarginTop) andRadius:rightPanelItemWidth/2];
        WQXKeyCircleButton *switchButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(rightPanelItemFullWidth*3+rightPanelLine1Indent, rightPanelItemMarginTop*2) andRadius:rightPanelItemWidth/2];
        
        WQXKeyCircleButton *enterButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(0, rightPanelItemFullWidth) andRadius:rightPanelItemWidth/2];
        WQXKeyCircleButton *menuButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(rightPanelItemFullWidth, rightPanelItemFullWidth+rightPanelItemMarginTop) andRadius:rightPanelItemWidth/2];
        WQXKeyCircleButton *saveButton = [[WQXKeyCircleButton alloc] initWithOrigin:CGPointMake(rightPanelItemFullWidth*2, rightPanelItemFullWidth+rightPanelItemMarginTop*2) andRadius:rightPanelItemWidth/2];
        
        [enterButton setTitle:@"确定" forState:UIControlStateNormal];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [menuButton setTitle:@"菜单" forState:UIControlStateNormal];
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [flyButton setTitle:@"飞行" forState:UIControlStateNormal];
        [switchButton setTitle:@"切换" forState:UIControlStateNormal];
        
        enterButton.tag = 0x1D;
        backButton.tag = 0x3B;
        menuButton.tag = 0x13;
        saveButton.tag = kWQXCustomKeyCodeSave;
        flyButton.tag = 0x10;
        switchButton.tag = kWQXCustomKeyCodeSwitch;
        
        [rightPanel addSubview:enterButton];
        [rightPanel addSubview:backButton];
        [rightPanel addSubview:menuButton];
        [rightPanel addSubview:saveButton];
        [rightPanel addSubview:flyButton];
        [rightPanel addSubview:switchButton];
        
        [self addSubview:leftPanel];
        [self addSubview:rightPanel];
        
        ////////////////////////////////////////////////////////////////////////////////////
        // Adds button events.
        ////////////////////////////////////////////////////////////////////////////////////
        UIImage *btnBgNroaml = [UIImage imageNamed:@"gmud_arrow_btn_normal"];
        UIImage *btnBgHighlighted = [UIImage imageNamed:@"gmud_arrow_btn_highlighted"];
        UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0f];
        NSMutableArray *buttons = [[NSMutableArray alloc] init];
        [buttons addObjectsFromArray:leftPanel.subviews];
        [buttons addObjectsFromArray:rightPanel.subviews];
        for (UIButton *button in buttons) {
            [button setBackgroundImage:btnBgNroaml forState:UIControlStateNormal];
            [button setBackgroundImage:btnBgHighlighted forState:UIControlStateHighlighted];
            button.titleLabel.font = labelFont;
            [button addTarget:self action:@selector(didButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(didButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(didButtonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        }
        
        return self;
    } else {
        return Nil;
    }
}

@end
