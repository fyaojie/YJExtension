//
//  UIImage+YJWatermark.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/6.
//  Copyright © 2018 child. All rights reserved.
//

#import "UIImage+YJWatermark.h"
@implementation NSString (YJWatermark)
//计算文字大小
- (CGSize)textSizeWithFont:(UIFont *)font
                   maxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end

@implementation UIImage (YJWatermark)

- (UIImage *)yj_watermarkWithText:(NSString *)text
                       level:(YJWaterMarkLevel)level
                    vertical:(YJWaterMarkVertical)vertical
                        font:(UIFont *)font
                       color:(UIColor *)color {
    
    if (text.length <= 0) {
        return self;
    }
    
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:40];
    }
    
    if (color == nil) {
        color = [UIColor redColor];
    }
    
    CGSize textSize = [text textSizeWithFont:font maxSize:self.size];
    
    CGFloat width = textSize.width;
    CGFloat height = textSize.height;
    
    CGFloat X = 0;
    CGFloat Y = 0;
    
    switch (level) {
        case YJWaterMarkLevel_left:
            X = 0;
            break;
        case YJWaterMarkLevel_center:
            X = (self.size.width - width) / 2.0;
            break;
        case YJWaterMarkLevel_right:
            X = self.size.width - width;
            break;
        default:
            break;
    }
    
    switch (vertical) {
        case YJWaterMarkVertical_top:
            Y = 0;
            break;
        case YJWaterMarkVertical_center:
            Y = (self.size.height - height) / 2.0;
            break;
        case YJWaterMarkVertical_bottom:
            Y = self.size.height - height;
            break;
        default:
            break;
    }

    UIGraphicsBeginImageContextWithOptions(self.size, false, 0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [text drawInRect:CGRectMake(X, Y, width, height) withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: color}];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)yj_watermarkWithImage:(UIImage *)image
                             level:(YJWaterMarkLevel)level
                          vertical:(YJWaterMarkVertical)vertical {
    
    if (self == nil || image == nil) {
        return self;
    }
    
    // 水印图的尺寸
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat scale = width / height;
    
    // 水印图的尺寸不允许超过父视图，任何一边超出自动按原比例缩放
    if (width > self.size.width) { // 宽度超出
        width = self.size.width;
        height = width / scale;
    }
    
    if (height > self.size.height) { // 高度超出
        height = self.size.height;
        height = height * scale;
    }
    
    CGFloat X = 0;
    CGFloat Y = 0;
    
    switch (level) {
        case YJWaterMarkLevel_left:
            X = 0;
            break;
        case YJWaterMarkLevel_center:
            X = (self.size.width - width) / 2.0;
            break;
        case YJWaterMarkLevel_right:
            X = self.size.width - width;
            break;
        default:
            break;
    }
    
    switch (vertical) {
        case YJWaterMarkVertical_top:
            Y = 0;
            break;
        case YJWaterMarkVertical_center:
            Y = (self.size.height - height) / 2.0;
            break;
        case YJWaterMarkVertical_bottom:
            Y = self.size.height - height;
            break;
        default:
            break;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [image drawInRect:CGRectMake(X, Y, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
