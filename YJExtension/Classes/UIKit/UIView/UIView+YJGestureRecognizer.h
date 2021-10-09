//
//  UIView+YJGestureRecognizer.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (YJGestureRecognizer)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)yj_addTapActionWithBlock:(GestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)yj_addLongPressActionWithBlock:(GestureActionBlock)block;

@end
