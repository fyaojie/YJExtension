//
//  UIImage+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

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
+ (UIImage*)yj_covertToGrayImageFromImage:(UIImage*)sourceImage;

/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage*)yj_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;

/**
 *  返回带有圆角和边框的图片
 *
 *  @param radius 圆角半径
 *  @param borderWidth 变宽的宽度
 *
 *  @return 返回之后的图片
 */
- (nullable UIImage *)yj_roundedCornerImage:(CGFloat)radius borderWidth:(CGFloat)borderWidth;
@end
