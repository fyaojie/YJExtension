//
//  NSString+YJURL.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YJURL)
/**
 *  @brief  将url 参数字符串转换成NSDictionary
 *
 *  @return 字典
 */
- (NSDictionary *)yj_URLQuery;
@end
