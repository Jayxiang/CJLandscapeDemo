//
//  BaseNavigationVC.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/1/23.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()

@end

@implementation BaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}
//是否可以旋转
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
//是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}
//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}
@end
