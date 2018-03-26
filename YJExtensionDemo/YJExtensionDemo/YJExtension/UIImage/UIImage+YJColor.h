//
//  UIImage+YJColor.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJColor)

/**
 *  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *  @param size  生成图片的大小
 *
 *  @return 图片
 */
+ (UIImage*)yj_imageWithColor:(UIColor *)color
                         size:(CGSize)size;

/**
 *  @brief  根据颜色生成纯色图片 (1*1)
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)yj_imageWithColor:(UIColor *)color;
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)yj_colorAtPoint:(CGPoint )point;
/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)yj_colorAtPixel:(CGPoint)point;

@end
