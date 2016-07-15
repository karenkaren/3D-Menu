//
//  MenuViewController.m
//  3D效果菜单
//
//  Created by LiuFeifei on 16/7/11.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemCell.h"
#import "DetailViewController.h"
#import "ContainerViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[MenuItemCell class] forCellReuseIdentifier:@"MenuItemCell"];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemCell" forIndexPath:indexPath];
    
    NSDictionary * menuItem = self.menuItemArray[indexPath.row];
    [cell configureForMenuItem:menuItem];
    return cell;
}

#pragma mark - Table View delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAX(80, CGRectGetHeight(self.view.bounds) / (CGFloat)self.menuItemArray.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * menuItem = self.menuItemArray[indexPath.row];
    if ([self.navigationController.parentViewController isKindOfClass:[ContainerViewController class]]) {
        ContainerViewController * containerViewController = (ContainerViewController *)self.navigationController.parentViewController;
        containerViewController.menuItem = menuItem;
    }
}

@end
