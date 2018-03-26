//
//  NSAttributedString+YJExtension.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (YJExtension)

/**
 *  textview的内容转化为html格式的字符串
 *
 *  @return 普通字符串 html
 */
- (NSString *)yj_conversionToHtmlString;

/**
 *  html转化为属性字符串，可直接显示在textview
 *
 *  @return 属性字符串
 */
+ (NSAttributedString *)yj_conversionToAttributedStringWithHtml:(NSString *)html;

@end
