//
//  BaseTabBarVC.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/1/23.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "BaseNavigationVC.h"

@interface BaseTabBarVC ()

@property (nonatomic, strong) NSArray *tabArr;

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTabBar];
}
- (void)creatTabBar {
    for (NSDictionary *dic in self.tabArr) {
        Class view = NSClassFromString(dic[@"vc"]);
        UIViewController *viewController = [[view alloc]init];
        viewController.tabBarItem.image = [UIImage imageNamed:dic[@"image"]];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:dic[@"selectImage"]];
        viewController.tabBarItem.title = dic[@"title"];
        BaseNavigationVC *nav = [[BaseNavigationVC alloc] initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }
}
- (NSArray *)tabArr {
    if (!_tabArr) {
        _tabArr = @[@{@"vc":@"CJPortraitVC",@"image":@"hengshuping_gray",@"selectImage":@"hengshuping",@"title":@"横竖屏"},];
    }
    return _tabArr;
}

// 是否可以旋转
- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}
// 由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}
// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return self.selectedViewController.prefersStatusBarHidden;
}
// 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}
//- (UIViewController *)childViewControllerForStatusBarStyle {
//    return self.selectedViewController;
//}

@end
