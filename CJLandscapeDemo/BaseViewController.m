//
//  BaseViewController.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/1/23.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

//是否可以旋转
- (BOOL)shouldAutorotate {
    return YES;
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
//是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}
//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
