//
//  UIImage+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UIImage+YJExtension.h"
#import "UIImage+YJAlpha.h"

@implementation UIImage (YJExtension)

+ (UIImage *)yj_captureWithView:(UIView *)view {
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */

+ (UIImage *)yj_covertToGrayImageFromImage:(UIImage *)sourceImage {
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage*)yj_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage {
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}
- (UIImage *)yj_roundedCornerImage:(CGFloat)radius borderWidth:(CGFloat)borderWidth {
    // If the image does not have an alpha layer, add one
    UIImage *image = self.yj_addAlpha;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderWidth, borderWidth, image.size.width - borderWidth * 2, image.size.height - borderWidth * 2)
                       context:context
                     ovalWidth:radius
                    ovalHeight:radius];
    CGContextClosePath(context);
    CGContextClip(context);
    
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

+ (UIImage *)yj_triangleImageWithColor:(UIColor *)color
                                   size:(CGSize)size
                              direction:(YJTriangleImageDirection)direction {
    /// 异常处理
    if (color == nil) { color = [UIColor blackColor]; }
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    if (imageWidth > 1000 || imageWidth < 1) { imageWidth = 30; }
    if (imageHeight > 1000 || imageHeight < 1) { imageHeight = imageWidth; }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (direction) {
        case YJTriangleImageDirectionRight:
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 0, imageHeight);
            CGContextAddLineToPoint(context, imageWidth, imageHeight * 0.5);
            break;
        case YJTriangleImageDirectionLeft:
            CGContextMoveToPoint(context, imageWidth, 0);
            CGContextAddLineToPoint(context, imageWidth, imageHeight);
            CGContextAddLineToPoint(context, 0, imageHeight * 0.5);
            break;
        case YJTriangleImageDirectionUp:
            CGContextMoveToPoint(context, imageWidth * 0.5, 0);
            CGContextAddLineToPoint(context, imageWidth, imageHeight);
            CGContextAddLineToPoint(context, 0, imageHeight);
            break;
        case YJTriangleImageDirectionDecline:
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, imageWidth, 0);
            CGContextAddLineToPoint(context, imageWidth * 0.5, imageHeight);
            break;
        default:
            break;
    }
    
    CGContextClosePath(context);
    /// 边框颜色填充
    [color setStroke];
    /// 内容填充
    [color setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)yj_arrowImageWithColor:(UIColor *)color size:(CGSize)size direction:(YJTriangleImageDirection)direction {
    return [self yj_arrowImageWithColor:color size:size direction:direction backgroudColor:[UIColor whiteColor]];
}

+ (UIImage *)yj_arrowImageWithColor:(UIColor *)color
                                size:(CGSize)size
                           direction:(YJTriangleImageDirection)direction
                      backgroudColor:(UIColor *)backgroudColor {
    /// 异常处理
    if (color == nil) { color = [UIColor grayColor]; }
    if (backgroudColor == nil) { backgroudColor = [UIColor whiteColor]; }
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    if (imageWidth > 1000 || imageWidth < 1) { imageWidth = 30; }
    if (imageHeight > 1000 || imageHeight < 1) { imageHeight = imageWidth; }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [backgroudColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, imageWidth, imageHeight));
    switch (direction) {
        case YJTriangleImageDirectionRight:
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, imageWidth, imageHeight * 0.5);
            CGContextAddLineToPoint(context, 0, imageHeight);
            break;
        case YJTriangleImageDirectionLeft:
            CGContextMoveToPoint(context, imageWidth, 0);
            CGContextAddLineToPoint(context, 0, imageHeight * 0.5);
            CGContextAddLineToPoint(context, imageWidth, imageHeight);
            break;
        case YJTriangleImageDirectionUp:
            CGContextAddLineToPoint(context, 0, imageHeight);
            CGContextMoveToPoint(context, imageWidth * 0.5, 0);
            CGContextAddLineToPoint(context, imageWidth, imageHeight);
            break;
        case YJTriangleImageDirectionDecline:
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, imageWidth * 0.5, imageHeight);
            CGContextAddLineToPoint(context, imageWidth, 0);
            break;
        default:
            break;
    }

//    CGContextClosePath(context);
    /// 边框颜色填充
    [color setStroke];
    /// 内容填充
//    [backgroudColor setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)yj_closeImageWithColor:(UIColor *)color size:(CGSize)size {
    return [self yj_closeImageWithColor:color backgroudColor:nil size:size lineWidth:1 isRound:NO];
}
+ (UIImage *)yj_closeImageWithColor:(UIColor *)color
                      backgroudColor:(UIColor * _Nullable)backgroudColor
                                size:(CGSize)size
                           lineWidth:(CGFloat)lineWidth
                             isRound:(BOOL)isRound {
    /// 异常处理
    if (color == nil) { color = [UIColor grayColor]; }
    if (backgroudColor == nil) { backgroudColor = [UIColor whiteColor]; }
    lineWidth = MIN(MAX(1, lineWidth), 10);
    
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    if (imageWidth > 1000 || imageWidth < 1) { imageWidth = 30; }
    if (imageHeight > 1000 || imageHeight < 1) { imageHeight = imageWidth; }

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (isRound) {
        imageWidth = MIN(imageWidth, imageHeight);
        imageHeight = imageWidth;
        [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageWidth, imageHeight) cornerRadius:imageWidth * 0.5] addClip];
    }
    CGContextSetFillColorWithColor(context, [backgroudColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, imageWidth, imageHeight));
    CGContextSetLineWidth(context, lineWidth);

    if (isRound) {
        CGContextMoveToPoint(context, imageWidth * 1 / 4.0, imageWidth * 1 / 4.0);
        CGContextAddLineToPoint(context, imageWidth * 3 / 4.0, imageWidth * 3 / 4.0);
        CGContextMoveToPoint(context, imageWidth * 3 / 4.0, imageWidth * 1 / 4.0);
        CGContextAddLineToPoint(context, imageWidth * 1 / 4.0, imageWidth * 3 / 4.0);
    } else {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, imageWidth, imageHeight);
        CGContextMoveToPoint(context, imageWidth, 0);
        CGContextAddLineToPoint(context, 0, imageHeight);
    }
    
    
//    CGContextClosePath(context);
    /// 边框颜色填充
    [color setStroke];
    /// 内容填充
//    [color setFill];
    CGContextStrokePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)yj_addImageWithColor:(UIColor *)color
                      backgroudColor:(UIColor *)backgroudColor
                                size:(CGSize)size
                           lineWidth:(CGFloat)lineWidth
                             isRound:(BOOL)isRound {
    /// 异常处理
    if (color == nil) { color = [UIColor grayColor]; }
    if (backgroudColor == nil) { backgroudColor = [UIColor whiteColor]; }
    lineWidth = MIN(MAX(1, lineWidth), 10);
    
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    if (imageWidth > 1000 || imageWidth < 1) { imageWidth = 30; }
    if (imageHeight > 1000 || imageHeight < 1) { imageHeight = imageWidth; }

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (isRound) {
        imageWidth = MIN(imageWidth, imageHeight);
        imageHeight = imageWidth;
        [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageWidth, imageHeight) cornerRadius:imageWidth * 0.5] addClip];
    }
    CGContextSetFillColorWithColor(context, [backgroudColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, imageWidth, imageHeight));
    CGContextSetLineWidth(context, lineWidth);

    CGContextMoveToPoint(context, imageWidth * 0.5, 0);
    CGContextAddLineToPoint(context, imageWidth * 0.5, imageHeight);
    CGContextMoveToPoint(context, 0, imageHeight * 0.5);
    CGContextAddLineToPoint(context, imageWidth, imageHeight * 0.5);
    
    
//    CGContextClosePath(context);
    /// 边框颜色填充
    [color setStroke];
    /// 内容填充
//    [color setFill];
    CGContextStrokePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


