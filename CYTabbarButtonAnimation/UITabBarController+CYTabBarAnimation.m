//
//  UITabBarController+CYTabBarAnimation.m
//  CYTabbarButtonAnimation
//
//  Created by 王超亚 on 2018/6/27.
//  Copyright © 2018年 王超亚. All rights reserved.
//

#import "UITabBarController+CYTabBarAnimation.h"
#import <objc/runtime.h>
static NSString *cy_indexKey = @"cy_indexKey";
static NSString *tabbarBtnsKey = @"tabbarBtnsKey";
@implementation UITabBarController (CYTabBarAnimation)
- (void)setCy_index:(NSInteger)cy_index{
    objc_setAssociatedObject(self, &cy_indexKey, [NSNumber numberWithInteger:cy_index], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)cy_index{
    
    NSNumber *index_N = objc_getAssociatedObject(self, &cy_indexKey);
    
    return index_N.integerValue;
}


- (void)setTabbarBtns:(NSMutableArray *)tabbarBtns{
    
    objc_setAssociatedObject(self, &tabbarBtnsKey, tabbarBtns, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)tabbarBtns{
    
    return objc_getAssociatedObject(self, &tabbarBtnsKey);
}

#pragma mark - UITabBarControllerDelegate
-(void)tabBardidSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setTabbarBtns];
    });
    
    if (index != self.cy_index) {
        //脉冲动画
        [self animationPulseWithIndex:index];
        self.cy_index = index;
    }else {
        //translation动画
        [self animationShakeWithIndex:index];
    }
}

/**
 抖动动画
 
 @param index 位置
 */
- (void)animationShakeWithIndex:(NSInteger) index {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-3];
    shake.toValue = [NSNumber numberWithFloat:3];
    shake.duration = 0.15;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 1;//次数
    [[self.tabbarBtns[index] layer]
     addAnimation:shake forKey:@"fb_tabbar_shake_animation"];
}

/**
 脉冲动画
 
 @param index 位置
 */
- (void)animationPulseWithIndex:(NSInteger) index {
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.15;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.85];
    pulse.toValue= [NSNumber numberWithFloat:1.15];
    [[self.tabbarBtns[index] layer]
     addAnimation:pulse forKey:@"fb_tabbar_pulse_animation"];
}

#pragma mark -- getter
- (void)setTabbarBtns{
        NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
        for (UIView *tabBarButton in self.tabBar.subviews) {
            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
            {
                [tabbarbuttonArray addObject:tabBarButton];
            }
        }
        self.tabbarBtns = tabbarbuttonArray;
    
}


@end
