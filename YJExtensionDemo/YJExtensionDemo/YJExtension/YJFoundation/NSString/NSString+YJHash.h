//
//  NSString+YJHash.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YJHash)
@property (readonly) NSString *md5;
@property (readonly) NSString *sha1;
@property (readonly) NSString *sha256;
@property (readonly) NSString *sha512;
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;
@end
