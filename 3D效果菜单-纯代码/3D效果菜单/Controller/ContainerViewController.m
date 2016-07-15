//
//  ContainerViewController.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/14.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "DetailViewController.h"
#import "MyNavigationViewController.h"
#import "Masonry.h"

@interface ContainerViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSArray * menuItemArray;
@property (nonatomic, strong) DetailViewController * detailController;
@property (nonatomic, strong) MenuViewController * menuController;
@end

@implementation ContainerViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViews];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self hideOrShowMenu:self.showingMenu animated:false];
    self.menuController.parentViewController.view.layer.anchorPoint = CGPointMake(1.0, 0.5);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Lazy loading
- (NSArray *)menuItemArray
{
    if (!_menuItemArray) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"];
        _menuItemArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _menuItemArray;
}

#pragma mark - setter method
- (void)setMenuItem:(NSDictionary *)menuItem
{
    _menuItem = menuItem;
    [self hideOrShowMenu:NO animated:YES];
    self.detailController.menuItem = menuItem;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame));
    
    CGFloat menuOffset = CGRectGetWidth(self.menuController.view.bounds);
    self.showingMenu = !CGPointEqualToPoint(CGPointMake(menuOffset, 0), scrollView.contentOffset);
    
    // 计算菜单按钮旋转角度的百分比
    CGFloat multiplier = 1.0 / CGRectGetWidth(self.menuController.view.bounds);
    CGFloat offset = self.scrollView.contentOffset.x * multiplier;
    CGFloat fraction = 1.0 - offset;
    // 设定菜单旋转、平移的组合transform
    self.menuController.parentViewController.view.layer.transform = [self transformForFraction:fraction];
    // 根据菜单按钮旋转进度设置菜单透明度
    self.menuController.view.alpha = fraction;
    // 根据菜单按钮旋转角度的百分比来选择菜单按钮
    HamburgerView * hamburgerView = self.detailController.hamburgerView;
    [hamburgerView rotate:fraction];
}

#pragma mark - private method
/**
 *  菜单形变
 *
 *  @param fraction 菜单按钮旋转进度
 *
 *  @return 返回菜单旋转、平移的组合transform
 */
- (CATransform3D)transformForFraction:(CGFloat)fraction
{
    // fraction：当menu完全隐藏时是0，完全显示时是1
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0 / 1000;
    CGFloat angle = (double)(1.0 - fraction) * (-M_PI_2);
    CGFloat xOffset = CGRectGetWidth(self.menuController.view.bounds) * 0.5;
    // 旋转
    CATransform3D rotateTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    // 平移
    CATransform3D translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0);
    // CATransform3DConcat负责把位置的transform和旋转的transform结合起来
    return CATransform3DConcat(rotateTransform, translateTransform);
}

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated
{
    CGFloat menuOffset = CGRectGetWidth(self.menuController.view.bounds);
    CGPoint point = show ? CGPointZero : CGPointMake(menuOffset, 0);
    [self.scrollView setContentOffset:point animated:animated];
    self.showingMenu = show;
}

- (void)addChildViews
{
    // 添加scroll view
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.scrollView];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width + 80, self.view.bounds.size.height)];
    [self.scrollView addSubview:contentView];
    self.scrollView.contentSize = contentView.bounds.size;
    
    MenuViewController * menuController = [[MenuViewController alloc] init];
    menuController.menuItemArray = self.menuItemArray;
    MyNavigationViewController * menuNavi = [[MyNavigationViewController alloc] initWithRootViewController:menuController];
    [self addChildViewController:menuNavi];
    [contentView addSubview:menuNavi.view];
    self.menuController = menuController;
    
    DetailViewController * detailController = [[DetailViewController alloc] init];
    detailController.menuItem = self.menuItemArray.firstObject;
    MyNavigationViewController * detailNavi = [[MyNavigationViewController alloc] initWithRootViewController:detailController];
    [self addChildViewController:detailNavi];
    [contentView addSubview:detailNavi.view];
    self.detailController = detailController;
    
    __block typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.view);
    }];
    
    [menuNavi.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.left.top.bottom.equalTo(contentView);
        make.right.equalTo(detailNavi.view.mas_left);
    }];
    
    [detailNavi.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(menuNavi.view.mas_right);
        make.top.bottom.equalTo(contentView);
        make.width.equalTo(weakSelf.view.mas_width);
    }];
}

@end
