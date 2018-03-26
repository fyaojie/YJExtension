//
//  NSAttributedString+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "NSAttributedString+YJExtension.h"
#import <UIKit/UIKit.h>

@implementation NSAttributedString (YJExtension)

- (NSString *)yj_conversionToHtmlString {
    
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    
    NSData *htmlData = [self dataFromRange:NSMakeRange(0, self.length) documentAttributes:exportParams error:nil];
    
    return [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
}

+ (NSAttributedString *)yj_conversionToAttributedStringWithHtml:(NSString *)html {
    NSData * htmlData=[html dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * importParams=@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};

    return [[NSAttributedString alloc]initWithData:htmlData options:importParams documentAttributes:NULL error:nil];
}

@end
