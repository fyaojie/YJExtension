//
//  NSDate+YJChineseCalendar.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJChineseCalendar)///农历
+ (NSCalendar *)yj_chineseCalendar;
//例如 五月初一
+ (NSString*)yj_currentMDDateString;
//例如 乙未年五月初一
+ (NSString*)yj_currentYMDDateString;
//例如 星期一
+ (NSString *)yj_currentWeek:(NSDate*)date;
//例如 星期一
+ (NSString *)yj_currentWeekWithDateString:(NSString*)datestring;
//例如 五月一
+ (NSString*)yj_currentCapitalDateString;
@end
