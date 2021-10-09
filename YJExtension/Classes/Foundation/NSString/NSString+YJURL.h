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
- (NSDictionary *)yj_URLQuery DEPRECATED_MSG_ATTRIBUTE("use yj_URLParse: ,该方法1.5.0版本后被废弃, 预计2.0版本删除");
/// 将url 参数字符串转换成NSDictionary
- (NSDictionary *)yj_URLParse;


@end
