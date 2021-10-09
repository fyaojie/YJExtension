//
//  UIView+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/5/31.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJExtension)

/// 扩大点击事件的范围, 这里一般情况要给予负值,否则可能无效
@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

/**
 *  当前view所在的viewcontroler
 */
- (UIViewController *)yj_viewController;

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)yj_screenshot;

/// 移除所有的子视图
- (void)yj_removeAllSubviews;
@end
