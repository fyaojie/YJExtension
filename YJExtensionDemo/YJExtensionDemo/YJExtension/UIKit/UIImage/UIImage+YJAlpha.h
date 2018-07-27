//
//  UIImage+YJAlpha.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJAlpha)
/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)yj_hasAlphaChannel;

/**
 *  图片添加alpha通道
 */
- (nullable UIImage *)yj_addAlpha;

/**
 设置图片的alpha值
 
 @param alpha alpha值
 @return 返回的图片
 */
-(nullable UIImage *)yj_setAlpha:(CGFloat )alpha;

/**
 *  图片添加边框
 *
 *  @param width 边框的宽度
 */
- (nullable UIImage *)yj_addBorder:(CGFloat)width;
@end
