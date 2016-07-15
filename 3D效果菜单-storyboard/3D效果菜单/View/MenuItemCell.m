//
//  MenuItemCell.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MenuItemCell.h"

@interface MenuItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *menuItemImageView;

@end

@implementation MenuItemCell

- (void)configureForMenuItem:(NSDictionary *)menuItem
{
    NSArray * colors = menuItem[@"colors"];
    NSString * imageName = menuItem[@"image"];
    UIImage * image = [UIImage imageNamed:imageName];
    self.menuItemImageView.contentMode = UIViewContentModeCenter;
    self.menuItemImageView.image = image;
    self.backgroundColor = [UIColor colorWithRed:[colors[0] floatValue] / 255 green:[colors[1] floatValue] / 255 blue:[colors[2] floatValue] / 255 alpha:1.0];
}

@end
