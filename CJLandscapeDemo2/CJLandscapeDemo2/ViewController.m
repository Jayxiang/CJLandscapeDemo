//
//  ViewController.m
//  CJLandscapeDemo2
//
//  Created by Jayxiang on 2021/3/10.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// 在系统自动旋转的情况下测试
- (IBAction)allowRotation:(id)sender {
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).allowOrentitaionRotation = YES;
}

- (IBAction)forbidRotation:(id)sender {
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).allowOrentitaionRotation = NO;
}

@end
