//
//  NSString+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "NSString+YJExtension.h"
#import "NSString+YJDevice.h"

@implementation NSString (YJExtension)

#pragma mark  获取随机字符串

+ (NSString *)yj_randomStringWithCount:(NSInteger)count {
    ///<>从字符数组中随机抽取相应数量的字符，组成验证码字符串
    //数组中存放的是全部可选的字符，可以是字母，也可以是中文
    NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    //如果能确定最大需要的容量，使用initWithCapacity:来设置，好处是当元素个数不超过容量时，添加元素不需要重新分配内存
    NSMutableString *changeString = [[NSMutableString alloc] initWithCapacity:count];
    
    //随机从数组中选取需要个数的字符，然后拼接为一个字符串
    for(int i = 0; i < count; i++)
    {
        NSInteger index = arc4random() % (arr.count - 1);
        
        [changeString appendString:arr[index]];
    }
    return changeString;
}

#pragma mark  手机号处理成中间*

- (NSString *)yj_telphoneHandle {
    if (self.length != 11) {
        return self;
    }
    return [NSString stringWithFormat:@"%@****%@",[self substringToIndex:3],[self substringFromIndex:7]];
}

#pragma mark  中文转码 -- 不会对中文进行二次转码
- (NSString *)yj_UTF8String {
    
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    if ([NSString yj_systemVersion].integerValue >= 9.0) {
        return encodedUrl;
    }
    
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 (CFStringRef)charactersToEscape,
                                                                                 NULL,
                                                                                 kCFStringEncodingUTF8));
}

#pragma mark  去掉首尾空格
- (NSString *)yj_clearFirstLastSpaces {
    if (!self || !self.length) {
        return nil;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


/// 过滤特殊字符
- (NSString *)yj_filterSpecialCharacters {
    
    __block NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *specialCharacters = @[@".",@"\n",@"\r",@"\t",@":",@" "];
    
    [specialCharacters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        result = [result stringByReplacingOccurrencesOfString:obj withString:@""];
    }];
    
    return result;
}
@end
