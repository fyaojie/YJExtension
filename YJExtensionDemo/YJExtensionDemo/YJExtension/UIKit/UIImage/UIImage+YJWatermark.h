//
//  UIImage+YJWatermark.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/6.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

//    水平方向的位置
typedef enum : NSUInteger {
    YJWaterMarkLevel_left,
    YJWaterMarkLevel_right,
    YJWaterMarkLevel_center,
} YJWaterMarkLevel;


// 竖直方向的位置
typedef enum : NSUInteger {
    YJWaterMarkVertical_top,
    YJWaterMarkVertical_bottom,
    YJWaterMarkVertical_center,
} YJWaterMarkVertical;


// 水印
@interface UIImage (YJWatermark)
// 文字水印
- (UIImage *)yj_watermarkWithText:(NSString *)text
                            level:(YJWaterMarkLevel)level
                         vertical:(YJWaterMarkVertical)vertical
                             font:(UIFont *)font
                            color:(UIColor *)color;
// 图片水印
- (UIImage *)yj_watermarkWithImage:(UIImage *)image
                             level:(YJWaterMarkLevel)level
                          vertical:(YJWaterMarkVertical)vertical;
@end
