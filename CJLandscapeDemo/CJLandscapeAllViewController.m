//
//  CJLandscapeAllViewController.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/1/24.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "CJLandscapeAllViewController.h"
#import <CoreMotion/CoreMotion.h>

//sensitive 灵敏度
static const float sensitive = 0.50;

@interface CJLandscapeAllViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) CMMotionManager *manager;
@property (nonatomic, assign) BOOL lockDirection;
@end

@implementation CJLandscapeAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"所有方向(不受锁定影响)";
    self.lockDirection = NO;
    if (self.manager.deviceMotionAvailable) {
        NSLog(@"Device Motion Available");
        [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                      withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                          [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
                                          
                                      }];
    } else {
        NSLog(@"No device motion on device.");
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.manager stopDeviceMotionUpdates];
}
- (IBAction)lockClick:(id)sender {
    self.lockDirection = !self.lockDirection;
    UIButton *lockBtn = (UIButton *)sender;
    lockBtn.selected = self.lockDirection;
}
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion {
    if (self.lockDirection) {
        return;
    }
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    if (fabs(y) >= fabs(x)) {
        if (y >= 0) {
            // UIDeviceOrientationPortraitUpsideDown;
            NSLog(@"界面直立，上下颠倒");
        } else {
            // UIDeviceOrientationPortrait;
            NSLog(@"界面直立");
            if (interfaceOrientation != UIInterfaceOrientationPortrait) {
                [self setInterfaceOrientation:UIInterfaceOrientationPortrait];
            }
        }
    } else {
        if (x > sensitive) {
            // UIDeviceOrientationLandscapeRight;
            NSLog(@"界面朝右");
            if (interfaceOrientation != UIInterfaceOrientationLandscapeLeft) {
                [self setInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
            }
        } else if (fabs(x) > sensitive) {
            // UIDeviceOrientationLandscapeLeft;
            NSLog(@"界面朝左");
            if (interfaceOrientation != UIInterfaceOrientationLandscapeRight) {
                [self setInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
            }

        } else {
            NSLog(@"界面直立");
        }
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
- (CMMotionManager *)manager {
    if (!_manager) {
        _manager = [[CMMotionManager alloc] init];
        _manager.deviceMotionUpdateInterval = 0.3;
    }
    return _manager;
}
- (IBAction)openClick:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{}];

}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//是否可以旋转
- (BOOL)shouldAutorotate {
    return !self.lockDirection;
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
