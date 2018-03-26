//
//  UIWindow+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (YJExtension)

@end

@interface UIWindow (YJHierarchy) // 层次结构

/*!
 @method topMostController   返回最前面的视图控制器
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)yj_topMostController;

/*!
 @method currentViewController   返回当前的视图控制器
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)yj_currentViewController;

@end
