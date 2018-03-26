//
//  UINavigationController+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UINavigationController+YJExtension.h"
#import <objc/runtime.h>

@implementation UINavigationController (YJExtension)

@end
@implementation UINavigationController (YJTransition)

- (void)yj_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    [self pushViewController:controller animated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController *)yj_popViewControllerWithTransition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:NULL];
    UIViewController *controller = [self popViewControllerAnimated:NO];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
    return controller;
}
@end
@implementation UINavigationController (YJPush)

#pragma mark 删除导航控制器中已拥有的重复控制器
/*
+(void)load{
    Method pushVC = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method YJpushVc = class_getInstanceMethod([self class], @selector(yj_pushViewController:animated:));
    method_exchangeImplementations(pushVC, YJpushVc);
}

-(void)yj_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (![self.topViewController isKindOfClass:[viewController class]]) {
        NSMutableArray *muarr = [NSMutableArray arrayWithArray:self.topViewController.navigationController.viewControllers];
        // 删除导航控制器中已拥有的重复控制器
        [muarr enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[viewController class]]) {
                [muarr removeObject:obj];
            }
        }];
        self.topViewController.navigationController.viewControllers = muarr;
        //        继续跳转
        [self yj_pushViewController:viewController animated:animated];
    }
}
*/

@end

