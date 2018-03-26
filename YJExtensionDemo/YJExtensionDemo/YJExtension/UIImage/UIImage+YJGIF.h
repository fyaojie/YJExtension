//
//  UIImage+YJGIF.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJGIF)

/**
 通过图片的二进制数据获取动态的gifimage
 
 @param data 二进制数据
 @return image
 */
+ (UIImage *)yj_animatedGIFWithData:(NSData *)data;

+ (UIImage *)yj_animatedGIFNamed:(NSString *)name;


@end
