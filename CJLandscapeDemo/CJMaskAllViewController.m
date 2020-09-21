//
//  CJMaskAllViewController.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/1/23.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "CJMaskAllViewController.h"

@interface CJMaskAllViewController ()<UITextViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *changeTextView;

@end

@implementation CJMaskAllViewController {
    BOOL hiddenStatus;
    BOOL isPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"所有方向(未锁定时)";
    self.changeTextView.text = @"滑动我改变状态栏颜色\n\n滑动我改变状态栏颜色\n滑动我改变状态栏颜色\n滑动我改变状态栏颜色\n滑动我改变状态栏颜色";
    self.changeTextView.selectable = NO;
    self.changeTextView.delegate = self;
    hiddenStatus = NO;
    isPortrait = YES;
    //手机锁定竖屏后，UIDeviceOrientationDidChangeNotification通知就失效了。
    //设备方向
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
    //以监听UIApplicationDidChangeStatusBarOrientationNotification通知为例
    //手机锁定竖屏此通知方法也失效了
    //页面方向
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusBarOrientationChange:)
                                name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
//界面方向改变的处理
- (void)statusBarOrientationChange:(NSNotification *)notification {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationUnknown: {
            NSLog(@"未知方向");
            break;
        }
            
        case UIInterfaceOrientationPortrait: {
            isPortrait = YES;
            NSLog(@"界面直立");
            break;
        }
            
        case UIInterfaceOrientationPortraitUpsideDown: {
            NSLog(@"界面直立，上下颠倒");
            break;
        }
        
        case UIInterfaceOrientationLandscapeLeft: {
            isPortrait = NO;
            NSLog(@"界面朝左");
            break;
        }
        
        case UIInterfaceOrientationLandscapeRight: {
            isPortrait = NO;
            NSLog(@"界面朝右");
            break;
        }
            
        default:
            break;
    }
}
//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上");
            break;
            
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下");
            break;
            
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            break;
            
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"屏幕直立，上下顛倒");
            break;
            
        default:
            NSLog(@"无法辨识");
            break;
    }
}

- (IBAction)hiddenClick:(id)sender {
    UIButton *hiddenBtn = (UIButton *)sender;
    hiddenBtn.selected = !hiddenStatus;
    hiddenStatus = !hiddenStatus;
    if (@available(iOS 13.0, *)) {
        NSLog(@"iOS 13 以上不能隐藏，但是可以添加颜色");
        // 可以自定义 statusBar，横屏需要另外判断
//        UIView *statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
//        statusBar.backgroundColor = [UIColor grayColor];
//        [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
    } else {
        UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
        statusBar.hidden= hiddenStatus;
    }
    //这种方式会导致页面上移可采用上面的方式
//    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
}
- (IBAction)changeClick:(id)sender {
    UIButton *changeBtn = (UIButton *)sender;
    changeBtn.selected = isPortrait;
    if (isPortrait) {
        [self setInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        [self setInterfaceOrientation:UIInterfaceOrientationPortrait];
    }
}
//强制转屏(锁定时也可使用)
- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        // 从2开始是因为前两个参数已经被selector和target占用
        [invocation setArgument:&orientation atIndex:2];
        [invocation invoke];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setNeedsStatusBarAppearanceUpdate];
}
//是否可以旋转
- (BOOL)shouldAutorotate {
    return YES;
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
//是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return hiddenStatus;
}
//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.changeTextView.contentOffset.y >= 20) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}
//状态栏改变动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}
- (void)dealloc {
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setInterfaceOrientation:UIInterfaceOrientationPortrait];
}
@end
