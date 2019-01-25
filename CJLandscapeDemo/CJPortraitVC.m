//
//  CJPortraitVC.m
//  CJLandscapeDemo
//
//  Created by tet-cjx on 2019/1/23.
//  Copyright © 2019 hyd-cjx. All rights reserved.
//

#import "CJPortraitVC.h"
#import "CJMaskAllViewController.h"
#import "CJLandscapeAllViewController.h"

@interface CJPortraitVC ()

@end

@implementation CJPortraitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"默认竖屏";
}
- (IBAction)pushClick:(id)sender {
    CJMaskAllViewController *maskAll = [CJMaskAllViewController new];
    [self.navigationController pushViewController:maskAll animated:YES];
}
- (IBAction)pushAClick:(id)sender {
    CJLandscapeAllViewController *maskA = [CJLandscapeAllViewController new];
    [self.navigationController pushViewController:maskA animated:YES];
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
