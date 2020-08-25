//
//  NSData+YJHash.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YJHash)
/**
 *  @brief  md5 NSData
 */
@property (readonly) NSData *yj_md5;
/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *yj_sha1;
/**
 *  @brief  sha256Data NSData
 */
@property (readonly) NSData *yj_sha256;
/**
 *  @brief  sha512Data NSData
 */
@property (readonly) NSData *yj_sha512;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yj_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yj_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yj_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yj_hmacSHA512DataWithKey:(NSData *)key;
@end
