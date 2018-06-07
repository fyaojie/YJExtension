//
//  UIView+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/5/31.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJExtension)

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
@end
