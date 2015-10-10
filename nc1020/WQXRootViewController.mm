//
//  MainViewController.m
//  nc1020
//
//  Created by eric on 15/8/20.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "nc1020.h"
#import "WQXRootViewController.h"
#import "WQXScreenLayout.h"
#import "WQXDefaultScreenLayout.h"
#import "WQXGMUDScreenLayout.h"
#import "WQXKeyItem.h"
#import "WQXToolbox.h"
#import "WQX.hpp"
#import "UIView+Toast.h"

@interface WQXRootViewController ()
{
    NSThread *_wqxLoopThread;
    WQXScreenLayout *_layout;
    CGRect _screenBounds;
}
@end

@implementation WQXRootViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [WQXToolbox colorWithRGB:0x222222];
    _screenBounds = [WQXToolbox rectForCurrentOrientation:self.view.bounds];

    WQX *wqx = [WQX sharedInstance];
    
    // Load screen layout.
    NSString *screenLayoutClassName = wqx.defaultLayoutClassName;
    _layout = [[NSClassFromString(screenLayoutClassName) alloc] initWithBounds:_screenBounds andKeyboardViewDelegate:self];
    [_layout attachToView:self.view];
    
    // Load archive.
    WQXArchive *archive = [wqx defaultArchive];
    if (archive == Nil) {
        archive = [WQX archiveWithName:@"default"];
        [wqx addArchive:archive];
        [wqx setDefaultArchive:archive];
        [wqx save];
    }
    
    wqx::WqxRom rom = [WQX wqxRomWithArchive:archive];
    
    NSLog(@"RAM path %s", rom.norFlashPath.c_str());
    NSLog(@"ROM path %s", rom.romPath.c_str());
    wqx::Initialize(rom);
    wqx::LoadNC1020();
    
    [[_layout lcdView] beginUpdate];
    _wqxLoopThread = [[NSThread alloc] initWithTarget:self selector:@selector(wqxloopThreadCallback) object:nil];
    
    [_wqxLoopThread start];
}

- (void)keyboardView:(WQXKeyboardView *)view didKeydown:(NSInteger)keyCode {
    if (keyCode < kWQXCustomKeyCodeBegin) {
        wqx::SetKey((uint8_t)keyCode, TRUE);
    }
    NSLog(@"Did keydown with keycode: %d\n", keyCode);
}

- (void)setScreenLayout:(WQXScreenLayout *)layout {
    if (_layout != Nil) {
        [_layout detachFromView:self.view];
    }
    _layout = layout;
    [[_layout lcdView] beginUpdate];
    [_layout attachToView:self.view];
}

- (void)switchScreenLayout {
    WQX *wqx = [WQX sharedInstance];
    NSString *className = [wqx switchLayout];
    [wqx save];
    WQXScreenLayout *layout = [[NSClassFromString(className) alloc] initWithBounds:_screenBounds andKeyboardViewDelegate:self];
    [self setScreenLayout:layout];
}

- (void)keyboardView:(WQXKeyboardView *)view didKeyup:(NSInteger)keyCode {
    if (keyCode < kWQXCustomKeyCodeBegin) {
        wqx::SetKey((uint8_t)keyCode, FALSE);
    } else {
        // Handle custom keys.
        switch (keyCode) {
            case kWQXCustomKeyCodeSwitch:
                [self switchScreenLayout];
                break;
            case kWQXCustomKeyCodeLoad:
                wqx::LoadNC1020();
                break;
            case kWQXCustomKeyCodeSave:
                wqx::SaveNC1020();
                [self.view makeToast:@"保存完毕" duration:1.0 position:CSToastPositionBottom];
                break;
            case kWQXCustomKeyCodeSeppdup:
                break;
            case kWQXCustomKeyCodeSpeedReset:
                break;
            default:
                break;
        }
    }
    NSLog(@"Did keyup with keycode: %d\n", keyCode);
}

- (void)wqxloopThreadCallback {
    while (true) {
        wqx::RunTimeSlice(20, false);
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[_layout lcdView] setNeedsDisplay];
        });
        [NSThread sleepForTimeInterval:0.02];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
