//
//  UITextView+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/5.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (YJExtension)

@end

@interface UITextView (YJInputLimit)
@property (assign, nonatomic)  NSInteger yj_maxLength;//if <=0, no limit
@end

@interface UITextView (YJSelect)
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

@interface UITextView (YJPinchZoom)
@property (nonatomic) CGFloat yj_maxFontSize, yj_minFontSize;

@property (nonatomic, getter = isYj_zoomEnabled) BOOL yj_zoomEnabled;
@end
