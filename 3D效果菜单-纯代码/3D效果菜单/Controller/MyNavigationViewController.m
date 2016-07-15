//
//  MyNavigationViewController.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/14.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MyNavigationViewController.h"

@interface MyNavigationViewController ()

@end

@implementation MyNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.clipsToBounds = YES;
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.translucent = NO;
}

@end
