//
//  UIButton+YJCountDown.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YJCountDown)


/**
 倒计时按钮 -- 在倒计时状态下禁止点击

 @param timeout 小于等于60s，如果大于60会 %60
 @param title 正常状态下的按钮内容
 @param waitTitle 在倒计时状态下按钮的标题
 */
- (void)yj_startTime:(NSInteger )timeout title:(NSString *)title waitTitle:(NSString *)waitTitle;

@end
