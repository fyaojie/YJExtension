//
//  NSString+YJURL.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import "NSString+YJURL.h"

@implementation NSString (YJURL)
- (NSDictionary *)yj_URLQuery {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *parameters = [self componentsSeparatedByString:@"&"];
    for(NSString *parameter in parameters) {
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if([contents count] == 2) {
            NSString *key = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSDictionary *)yj_URLParse {
    if (self == nil || self.length <= 0) { return @{}; }
    NSString *text = self;
    if (![text containsString:@"?"]) {
        text = [@"?" stringByAppendingString:text];
    }
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:text];
    for (NSURLQueryItem *item in components.queryItems) {
        if (item.name) {
            [muDict setObject:item.value forKey:item.name];
        }
    }
    return muDict.copy;
}

@end
