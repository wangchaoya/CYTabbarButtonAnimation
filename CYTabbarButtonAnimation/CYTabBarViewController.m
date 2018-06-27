//
//  CYTabBarViewController.m
//  CYTabbarButtonAnimation
//
//  Created by 王超亚 on 2018/6/27.
//  Copyright © 2018年 王超亚. All rights reserved.
//

#import "CYTabBarViewController.h"
#import "CYNavigationViewController.h"
#import "UIImage+Image.h"
#import "UITabBarController+CYTabBarAnimation.h"
@interface CYTabBarViewController ()
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *tabbarBtns;
@end

@implementation CYTabBarViewController
#pragma mark -- life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([self respondsToSelector:NSSelectorFromString(@"tabBardidSelectItem:")]) {
        [self performSelector:NSSelectorFromString(@"tabBardidSelectItem:") withObject:item afterDelay:0];
    }
}

#pragma mark -- private
#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController{
    
    // 首页
    UIViewController *homeVc = [[UIViewController alloc] init];
    homeVc.view.backgroundColor = [UIColor whiteColor];
    [self setUpOneChildViewController:homeVc image:[UIImage imageNamed:@"iconindex-1"] selectedImage:[UIImage imageWithOriginalName:@"iconindexfill-1"] title:@"首页"];
    
    
    //消息
    UIViewController *messageList = [[UIViewController alloc] init];

    messageList.view.backgroundColor = [UIColor whiteColor];
    [self setUpOneChildViewController:messageList image:[UIImage imageNamed:@"icon_message_normal"] selectedImage:[UIImage imageWithOriginalName:@"icon_message_pressed"] title:@"消息"];

    UIViewController *contact = [[UIViewController alloc] init];
    contact.view.backgroundColor = [UIColor whiteColor];

    
    [self setUpOneChildViewController:contact image:[UIImage imageNamed:@"icon_contact_normal"] selectedImage:[UIImage imageWithOriginalName:@"icon_contact_pressed"] title:@"联系人"];
    // 我的
    UIViewController *profile = [[UIViewController alloc] init];
    profile.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"icon_setting_normal"] selectedImage:[UIImage imageWithOriginalName:@"icon_setting_pressed"] title:@"我的"];
    
    self.tabBar.translucent = false;
    
}


#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    //    // navigationItem模型
    //    vc.navigationItem.title = title;
    //
    //    // 设置子控件对应tabBarItem的模型属性
    //    vc.tabBarItem.title = title;
    vc.title = title;
    //    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
    //    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-20, 0, 10, 0);
    CYNavigationViewController *nav = [[CYNavigationViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}


@end
