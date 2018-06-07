//
//  UIControl+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (YJExtension)

@end

@interface UIControl (YJBlock) // 事件回调

/**
 单击按下
 */
- (void)yj_touchDown:(void (^)(id x))eventBlock;

/**
 鼠标左键连续多次重复按下（注：只是“按下”）的动作，比如，鼠标连续双击、三击、……、多次连击
 */
- (void)yj_touchDownRepeat:(void (^)(id x))eventBlock;

/**
 按下鼠标，然后在控件边界范围内拖动。
 */
- (void)yj_touchDragInside:(void (^)(id x))eventBlock;

/**
 拖动时，鼠标位于控件边界范围之外
 */
- (void)yj_touchDragOutside:(void (^)(id x))eventBlock;

/**
 拖动动作中，从控件边界外到内时产生的事件
 */
- (void)yj_touchDragEnter:(void (^)(id x))eventBlock;

/**
 拖动动作中，从控件边界内到外时产生的事件
 */
- (void)yj_touchDragExit:(void (^)(id x))eventBlock;

/**
 鼠标在控件范围内抬起
 */
- (void)yj_touchUpInside:(void (^)(id x))eventBlock;

/**
 鼠标在控件边界范围外抬起
 */
- (void)yj_touchUpOutside:(void (^)(id x))eventBlock;
- (void)yj_touchCancel:(void (^)(id x))eventBlock;
- (void)yj_valueChanged:(void (^)(id x))eventBlock;
- (void)yj_editingDidBegin:(void (^)(id x))eventBlock;
- (void)yj_editingChanged:(void (^)(id x))eventBlock;
- (void)yj_editingDidEnd:(void (^)(id x))eventBlock;
- (void)yj_editingDidEndOnExit:(void (^)(id x))eventBlock;

@end

@interface UIControl (YJSound) // 按钮触发声音
/**
 * 不同的操作状态触发不同的声音
 */
- (void)yj_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;
@end

