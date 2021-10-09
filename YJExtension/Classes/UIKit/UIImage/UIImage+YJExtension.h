//
//  UIImage+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
/// 三角形绘制方向
typedef enum : NSUInteger {
    YJTriangleImageDirectionDecline, /// 向下
    YJTriangleImageDirectionUp, /// 向上
    YJTriangleImageDirectionLeft, /// 向左
    YJTriangleImageDirectionRight /// 向右
} YJTriangleImageDirection;

@interface UIImage (YJExtension)

/**
 *  截取当前视图上的图片
 *
 *  @param view 视图所在的View
 *
 *  @return 返回的图片
 */
+ (nullable UIImage *)yj_captureWithView:(nullable UIView *)view;


/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (nullable UIImage *)yj_covertToGrayImageFromImage:(UIImage *_Nonnull)sourceImage;

/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage *_Nonnull)yj_mergeImage:(UIImage *_Nonnull)firstImage withImage:(UIImage *_Nonnull)secondImage;

/**
 *  返回带有圆角和边框的图片
 *
 *  @param radius 圆角半径
 *  @param borderWidth 变宽的宽度
 *
 *  @return 返回之后的图片
 */
- (nullable UIImage *)yj_roundedCornerImage:(CGFloat)radius borderWidth:(CGFloat)borderWidth;

/// 绘制三角形
/// @param color 填充颜色
/// @param size 绘制大小
/// @param direction 三角形箭头朝向
+ (UIImage *)yj_triangleImageWithColor:(UIColor *)color
                                   size:(CGSize)size
                              direction:(YJTriangleImageDirection)direction;


/// 绘制箭头
/// @param color 线条颜色
/// @param size 绘制大小
/// @param direction 三角形箭头朝向
+ (UIImage *)yj_arrowImageWithColor:(UIColor *)color
                                   size:(CGSize)size
                              direction:(YJTriangleImageDirection)direction;

/// 绘制箭头
/// @param color 线条颜色
/// @param size 绘制大小
/// @param direction 箭头朝向
/// @param backgroudColor 背景颜色
+ (UIImage *)yj_arrowImageWithColor:(UIColor *)color
                                size:(CGSize)size
                           direction:(YJTriangleImageDirection)direction
                      backgroudColor:(UIColor *)backgroudColor;

/// 绘制关闭按钮
/// @param color 颜色
/// @param size size
+ (UIImage *)yj_closeImageWithColor:(UIColor *)color
                                  size:(CGSize)size;

/// 绘制关闭按钮图片
/// @param color 线条颜色
/// @param backgroudColor 背景颜色
/// @param size 图片大小
/// @param lineWidth 线宽
/// @param isRound 是否是圆形
+ (UIImage *)yj_closeImageWithColor:(UIColor *)color
                      backgroudColor:(UIColor * _Nullable)backgroudColor
                                size:(CGSize)size
                           lineWidth:(CGFloat)lineWidth
                             isRound:(BOOL)isRound;

+ (UIImage *)yj_addImageWithColor:(UIColor *)color
                      backgroudColor:(UIColor *)backgroudColor
                                size:(CGSize)size
                           lineWidth:(CGFloat)lineWidth
                             isRound:(BOOL)isRound;

@end

