//
//  UITextField+YJSelect.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YJSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)yj_selectedRange;
/**
 *  @brief  选中所有文字  进入编辑状态才会生效
 */
- (void)yj_selectAllText;
/**
 *  @brief  选中指定范围的文字 进入编辑状态才会生效
 *
 *  @param range NSRange范围
 */
- (void)yj_setSelectedRange:(NSRange)range;
@end
