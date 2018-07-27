//
//  NSString+YJEmoji.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YJEmoji)

/**
 表情字符串转Unicode
 */
- (NSString *)yj_stringByReplacingEmojiCheatCodesWithUnicode;
/**
 Unicode转表情字符串
 */
- (NSString *)yj_stringByReplacingEmojiUnicodeWithCheatCodes;
/// 是否是emoji表情
- (BOOL)yj_isEmoji;
/// 是否包含emoji表情
- (BOOL)yj_isIncludingEmoji;
/// 清除其中的emoji表情
- (NSString *)yj_cleanEmoji;
@end
