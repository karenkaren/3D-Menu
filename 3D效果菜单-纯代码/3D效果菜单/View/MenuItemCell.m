//
//  MenuItemCell.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MenuItemCell.h"
#import "Masonry.h"

@interface MenuItemCell ()

@property (strong, nonatomic) UIImageView * menuItemImageView;

@end

@implementation MenuItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.menuItemImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.menuItemImageView];
    }
    return self;
}

- (void)configureForMenuItem:(NSDictionary *)menuItem
{
    __block typeof(self) weakSelf = self;
    [self.menuItemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf);
    }];
    NSArray * colors = menuItem[@"colors"];
    NSString * imageName = menuItem[@"image"];
    UIImage * image = [UIImage imageNamed:imageName];
    self.menuItemImageView.contentMode = UIViewContentModeCenter;
    self.menuItemImageView.image = image;
    self.backgroundColor = [UIColor colorWithRed:[colors[0] floatValue] / 255 green:[colors[1] floatValue] / 255 blue:[colors[2] floatValue] / 255 alpha:1.0];
}

@end
