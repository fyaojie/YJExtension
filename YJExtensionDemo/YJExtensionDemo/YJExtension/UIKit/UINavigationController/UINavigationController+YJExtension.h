//
//  UINavigationController+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (YJExtension)

@end

@interface UINavigationController (YJTransition) // 过渡动画

/**  UIViewAnimationTransition
 *  UIViewAnimationTransitionNone,//不使用动画
 *  UIViewAnimationTransitionFlipFromLeft,//从左向右旋转翻页
 *  UIViewAnimationTransitionFlipFromRight,//从右向左旋转翻页
 *  UIViewAnimationTransitionCurlUp,//从下往上卷曲翻页
 *  UIViewAnimationTransitionCurlDown,//从上往下卷曲翻页
 */


- (void)yj_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;

- (UIViewController *)yj_popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end


