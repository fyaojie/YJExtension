//
//  UIButton+YJEnlargeEdge.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YJEnlargeEdge) // 提高热区

/** 设置可点击范围到按钮边缘的距离 */
- (void)setEnlargeEdge:(CGFloat)enlargeEdge;

/** 设置可点击范围到按钮上、右、下、左的距离 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
