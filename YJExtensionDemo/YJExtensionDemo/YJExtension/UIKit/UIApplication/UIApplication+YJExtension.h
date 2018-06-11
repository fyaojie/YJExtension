//
//  UIApplication+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/5/31.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (YJExtension)
/**
    计算整个程序所占用的内存大小
 */
- (NSString *)yj_applicationSize;
@end

@interface UIApplication (YJAPPIcon)
/**
 icon 路径
 */
- (NSString*)yj_appIconPath;
/**
 icon 图标
 */
- (UIImage*)yj_appIcon;
@end
