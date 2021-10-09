//
//  NSDictionary+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YJExtension)

// 数据便利
- (void)yj_each:(void (^)(id key, id value))block;
// 返回处理后的数据
- (NSArray *)yj_map:(id (^)(id key, id value))block;

@end

@interface NSDictionary (YJJSON)
// 转json
- (NSString *)yj_JSONString;
@end

@interface NSDictionary (YJURL)

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)yj_URLQueryString;
@end
