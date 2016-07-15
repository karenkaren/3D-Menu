//
//  ContainerViewController.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ContainerViewController.h"
#import "HamburgerView.h"

@interface ContainerViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *menuContainerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) DetailViewController * detailViewController;

@end

@implementation ContainerViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self hideOrShowMenu:self.showingMenu animated:false];
    self.menuContainerView.layer.anchorPoint = CGPointMake(1.0, 0.5);
}

/**
 *  StatusBar的content颜色
 *
 *  @return StatusBarStyle
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewSegue"]) {
        UINavigationController * navigationViewController = segue.destinationViewController;
        self.detailViewController = (DetailViewController * )navigationViewController.topViewController;
    }
}

#pragma mark - setter method
- (void)setMenuItem:(NSDictionary *)menuItem
{
    _menuItem = menuItem;
    [self hideOrShowMenu:NO animated:YES];
    self.detailViewController.menuItem = menuItem;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 解决菜单回弹问题
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame));
    
    CGFloat menuOffset = CGRectGetWidth(self.menuContainerView.bounds);
    self.showingMenu = !CGPointEqualToPoint(CGPointMake(menuOffset, 0), scrollView.contentOffset);
    
    // 计算菜单按钮旋转角度的百分比
    CGFloat multiplier = 1.0 / CGRectGetWidth(self.menuContainerView.bounds);
    CGFloat offset = self.scrollView.contentOffset.x * multiplier;
    CGFloat fraction = 1.0 - offset;
    // 设定菜单旋转、平移的组合transform
    self.menuContainerView.layer.transform = [self transformForFraction:fraction];
    // 根据菜单按钮旋转进度设置菜单透明度
    self.menuContainerView.alpha = fraction;
    // 根据菜单按钮旋转角度的百分比来选择菜单按钮
    HamburgerView * hamburgerView = self.detailViewController.hamburgerView;
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
    CGFloat xOffset = CGRectGetWidth(self.menuContainerView.bounds) * 0.5;
    // 旋转
    CATransform3D rotateTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    // 平移
    CATransform3D translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0);
    // CATransform3DConcat负责把位置的transform和旋转的transform结合起来
    return CATransform3DConcat(rotateTransform, translateTransform);
}

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated
{
    CGFloat menuOffset = CGRectGetWidth(self.menuContainerView.bounds);
    CGPoint point = show ? CGPointZero : CGPointMake(menuOffset, 0);
    [self.scrollView setContentOffset:point animated:animated];
    self.showingMenu = show;
}

@end
