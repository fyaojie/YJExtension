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
- (void)each:(void (^)(id key, id value))block;
// 返回处理后的数据
- (NSArray *)map:(id (^)(id key, id value))block;
// 转json
- (NSString *)jsonString;
@end
