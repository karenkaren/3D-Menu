//
//  DetailViewController.h
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerView.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary * menuItem;
@property (strong, nonatomic) HamburgerView * hamburgerView;

@end
