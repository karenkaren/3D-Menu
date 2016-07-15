//
//  HamburgerView.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/12.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "HamburgerView.h"

@interface HamburgerView ()

@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation HamburgerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    [self addSubview:self.imageView];
}

- (void)rotate:(CGFloat)fraction
{
    CGFloat angle = (double)fraction * M_PI_2;
    self.imageView.transform = CGAffineTransformMakeRotation(angle);
}

@end
