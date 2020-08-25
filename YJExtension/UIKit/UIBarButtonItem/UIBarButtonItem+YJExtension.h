//
//  UIBarButtonItem+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJItemType) {
    YJItemTypeLeft = 0,                // 左边的按钮
    YJItemTypeRight = 1,               // 右边的按钮
};

typedef void(^YJTouchedBarButtonItemBlock)(UIButton *sender);

@interface UIBarButtonItem (YJExtension)

/**
 创建带有角标的通知按钮
 
 @param bageValue 角标
 @param action 事件
 @return 按钮
 */
+ (UIBarButtonItem *)createBageValueNoticeButtonWithBageValue:(NSInteger)bageValue
                                                       target:(id)target
                                                       action:(SEL)action;

/**
 图标UIBarButtonItem
 
 @param type         左侧or右侧按钮
 @param norImage     按钮图标
 @param highImage    按钮高亮图标
 @param offset       图标偏移量
 @param touchHandler 点击事件处理
 
 */
+ (instancetype)yj_itemWithType:(YJItemType)type
                       norImage:(NSString *)norImage
                      highImage:(NSString *)highImage
                         offset:(CGFloat)offset
                  actionHandler:(YJTouchedBarButtonItemBlock)touchHandler;




/**
 文字UIBarButtonItem
 
 @param type         左侧or右侧按钮
 @param norTitle     普通状态文字
 @param font         文字字体大小
 @param norColor     普通状态文字颜色
 @param highColor    高亮状态文字颜色
 @param offset       偏移量
 @param touchHandler 点击事件处理
 
 */
+ (instancetype)yj_itemWithType:(YJItemType)type
                       norTitle:(NSString *)norTitle
                           font:(CGFloat)font
                       norColor:(UIColor *)norColor
                      highColor:(UIColor *)highColor
                         offset:(CGFloat)offset
                  actionHandler:(YJTouchedBarButtonItemBlock)touchHandler;

@end
