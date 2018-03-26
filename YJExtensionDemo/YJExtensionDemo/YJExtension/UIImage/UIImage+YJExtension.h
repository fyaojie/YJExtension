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
 *  通过view 生成图片
 *
 *  @param orgView 要生成图片的view
 *
 *  @return 图片
 */
+ (UIImage *)yj_imageFromView:(UIView *)orgView;


/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)yj_hasAlphaChannel;

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
+ (UIImage*)jk_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;
@end
