//
//  NSData+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/5/15.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YJExtension)
/**
    data转字符串
    解决在某些情况下转换失败的问题（原因是包含非utf8编码格式）
 */
- (NSString *)yj_UTF8String;

@end

@interface NSData (YJMD5)

/**
 MD5获取文件摘要

 @param file 文件路径
 @return 文件摘要
 */
+ (NSString *)yj_md5AbstractWithFile:(NSString *)file;
@end
