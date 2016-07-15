//
//  DetailViewController.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "DetailViewController.h"
#import "ContainerViewController.h"
#import "Masonry.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIImageView * bigItemImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 为菜单按钮视图添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hamburgerViewTapped)];
    self.hamburgerView = [[HamburgerView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.hamburgerView addGestureRecognizer:tap];
    // 设置leftBarButtonItem为菜单按钮视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.hamburgerView];
}

#pragma mark - Lazy loading
- (UIImageView *)bigItemImageView
{
    if (!_bigItemImageView) {
        _bigItemImageView = [[UIImageView alloc] init];
        [self.view addSubview:self.bigItemImageView];
        
        __block typeof(self) weakSelf = self;
        [self.bigItemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.view.mas_centerX);
            make.centerY.equalTo(weakSelf.view.mas_centerY);
            make.width.height.equalTo(@320);
        }];
    }
    return _bigItemImageView;
}

#pragma mark - 手势处理
- (void)hamburgerViewTapped
{
    UINavigationController * navigationController = (UINavigationController * )self.parentViewController;
    ContainerViewController * containerViewController = (ContainerViewController *)navigationController.parentViewController;
    [containerViewController hideOrShowMenu:!containerViewController.showingMenu animated:YES];
}

#pragma mark - setter method
- (void)setMenuItem:(NSDictionary *)menuItem
{
    _menuItem = menuItem;

    NSString * bigImage = menuItem[@"bigImage"];
    NSArray * colors = menuItem[@"colors"];
    self.bigItemImageView.image = [UIImage imageNamed:bigImage];
    self.view.backgroundColor = [UIColor colorWithRed:[colors[0] floatValue] / 255 green:[colors[1] floatValue] / 255 blue:[colors[2] floatValue] / 255 alpha:1.0];
}

@end
