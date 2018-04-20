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
 *  根据颜色值生成图片
 *
 *  @param color 添加的颜色值
 *
 *  @return 生成的图片
 */
+ (nullable UIImage*)yj_imageWithColor:(nullable UIColor *)color;

/**
 *  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *  @param size  生成图片的大小
 *
 *  @return 图片
 */
+ (UIImage*)yj_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成一个颜色渐变的背景图
 *
 *  @param colors 传递的颜色值
 *  @param frame  设置图片大小
 *
 *  @return 生成的图片
 */
+ (nullable UIImage*)yj_gradientImage:(nullable NSArray<UIColor *> *)colors withFrame: (CGRect)frame;

/**
 *  利用CAGradientLayer创建颜色渐变的图层
 *
 *  @param colorsArr   颜色数组
 *  @param locationArr 分割点数组
 *  @param startPoint  颜色渐变的起点 (0,0),(0,1)……
 *  @param endPoint    颜色渐变的终点 (0,0),(0,1)……
 *  @param layerFrame  生成的图层的frame
 *
 *  @return 颜色渐变的图层
 */
+ (nullable CAGradientLayer*)createGradientLayer:(nullable NSArray<UIColor *> *)colorsArr location:(nullable NSArray*)locationArr start:(CGPoint)startPoint end:(CGPoint)endPoint frame:(CGRect)layerFrame;

/**
 *  图片在某一个点的颜色值
 *
 *  @param point 在图像的那个点
 *
 *  @return 返回的颜色值
 */
- (nullable UIColor *)yj_colorAtPoint:(CGPoint )point;

/**
 *  某一个点的像素
 *
 *  @param point 图像上的点
 *
 *  @return 返回的像素
 */
- (nullable UIColor *)yj_colorAtPixel:(CGPoint)point;

@end
