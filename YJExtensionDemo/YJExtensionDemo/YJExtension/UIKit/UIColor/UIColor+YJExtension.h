//
//  UIColor+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YJExtension)

/**
 随机颜色
 */
+ (instancetype)yj_random;

+ (UIColor *)yj_colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

@end
