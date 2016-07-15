//
//  ContainerViewController.h
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ContainerViewController : UIViewController

@property (nonatomic, strong) NSDictionary * menuItem;
@property (nonatomic, assign) BOOL showingMenu;

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated;

@end
