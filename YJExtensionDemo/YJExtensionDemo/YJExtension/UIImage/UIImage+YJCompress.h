//
//  UIImage+YJCompress.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJCompress)  //压缩

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)yj_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)yj_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)yj_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

/**
 对该图片的中心1像素进行拉伸
 */
+ (UIImage*)yj_resizableHalfImage:(NSString *)name;

/**
 图片压缩
 
 @param image 图片
 @param maxLength 不超过多少  例如 32K  32 * 1024
 @return 压缩之后的图片
 */
+ (UIImage *)yj_compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
@end
