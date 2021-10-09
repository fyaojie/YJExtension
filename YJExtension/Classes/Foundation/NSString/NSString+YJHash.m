//
//  NSString+YJHash.m
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import "NSString+YJHash.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (YJHash)
- (NSString *)yj_md5
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self yj_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}
- (NSString *)yj_sha1
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self yj_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}
- (NSString *)yj_sha224 {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA224(string, length, bytes);
    return [self yj_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)yj_sha256
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self yj_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)yj_sha384
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA384(string, length, bytes);
    return [self yj_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)yj_sha512
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self yj_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)yj_hmacMD5StringWithKey:(NSString *)key {
    return [self yj_hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}
- (NSString *)yj_hmacSHA1StringWithKey:(NSString *)key
{
    return [self yj_hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
    
}
- (NSString *)yj_hmacSHA224StringWithKey:(NSString *)key{
    return [self yj_hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}
- (NSString *)yj_hmacSHA256StringWithKey:(NSString *)key
{
    return [self yj_hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
    
}
- (NSString *)yj_hmacSHA384StringWithKey:(NSString *)key{
    return [self yj_hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}
- (NSString *)yj_hmacSHA512StringWithKey:(NSString *)key
{
    return [self yj_hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
    
}
#pragma mark - Helpers
- (NSString *)yj_hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:size];
    CCHmac(alg, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self yj_stringFromBytes:(unsigned char *)mutableData.bytes length:(int)mutableData.length];
}
- (NSString *)yj_stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

static int encryptPara = 2;
- (NSString *)yj_encrypt {
    if (self == nil || self.length <= 0) return @"";
    NSMutableString *resultStringM = [[NSMutableString alloc] initWithCapacity:self.length];
    for (int i = 0; i < self.length; i ++) {
        unichar c = [self characterAtIndex:i];
        //加密:简单的对每个字符的asci码加EncryptPara
        [resultStringM appendFormat:@"%c",c + encryptPara];
    
    }
    return resultStringM;
}

- (NSString *)yj_decrypt {
    if (self == nil || self.length <= 0) return @"";
    NSMutableString *resultStringM = [[NSMutableString alloc] initWithCapacity:self.length];
    for (int i = 0; i < self.length; i ++) {
        unichar c = [self characterAtIndex:i];
        //加密:简单的对每个字符的asci码加EncryptPara
        [resultStringM appendFormat:@"%c",c - encryptPara];
    
    }
    return resultStringM;
}

@end
