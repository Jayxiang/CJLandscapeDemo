//
//  CJTransformVC.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/7/30.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "CJTransformVC.h"

@interface CJTransformVC ()

@end

@implementation CJTransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"利用动画旋转横屏";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 55, 150, 30);
    [button setTitle:@"利用动画旋转横屏" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 旋转角度 0.5➡️横屏 1.5⬅️横屏 2⬆️竖屏 1⬇️竖屏
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;//时间
    [UIView animateWithDuration:duration animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
        self.navigationController.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //视图将要消失的时候 再把视图翻转回来 ，不会影响其他VC的展示
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI*2);
        self.navigationController.view.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
//是否可以旋转
- (BOOL)shouldAutorotate {
    return NO;
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
