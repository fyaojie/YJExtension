//
//  NSString+YJSimilarity.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/8.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, YJScoreOption) {
    YJScoreOptionNone = 1 << 0,
    YJScoreOptionFavorSmallerWords = 1 << 1,
    YJScoreOptionReducedLongStringPenalty = 1 << 2
};

@interface NSString (YJSimilarity) //模糊匹配字符串 查找某两个字符串的相似程度
- (CGFloat)yj_scoreAgainst:(NSString *)otherString;
- (CGFloat)yj_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat)yj_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(YJScoreOption)options;
@end
