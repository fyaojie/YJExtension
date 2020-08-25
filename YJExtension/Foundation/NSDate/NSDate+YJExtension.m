//
//  NSDate+YJExtension.m
//  分类研究
//
//  Created by 冯垚杰 on 2017/8/14.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "NSDate+YJExtension.h"
#import <UIKit/UIKit.h>

#define YJ_D_MINUTE    60
#define YJ_D_HOUR    3600
#define YJ_D_DAY    86400
#define YJ_D_WEEK    604800
#define YJ_D_YEAR    31556926

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#define YJ_NSDATE_UTILITIES_COMPONENT_FLAGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
({ \
unsigned components;\
if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){ \
components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
}else{ \
components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
} \
components; \
})\
_Pragma("clang diagnostic pop") \

#else
#define YJ_NSDATE_UTILITIES_COMPONENT_FLAGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
({\
unsigned components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
components; \
})\
_Pragma("clang diagnostic pop") \

#endif

@implementation NSDate (YJExtension)

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
//取得当前用户的逻辑日历
//currentCalendar取得的值会一直保持在cache中,第一次取得以后如果用户修改该系统日历设定，这个值也不会改变。
//用autoupdatingCurrentCalendar，那么每次取得的值都会是当前系统设置的日历的值
+ (NSCalendar *) yj_currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *)yj_dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] yj_dateByAddingDays:days];
}



+ (NSDate *) yj_dateTomorrow { return [NSDate yj_dateWithDaysFromNow:1]; }

+ (NSDate *) yj_dateYesterday { return [NSDate yj_dateWithDaysFromNow:-1]; }

+ (NSDate *) yj_dateWithHoursFromNow: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) yj_dateWithMinutesFromNow: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSString *)yj_weekdayString {return [NSDate yj_weekdayString:self];}

+ (NSString *)yj_weekdayString:(NSDate *)date {
    
    NSArray *CN = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSArray *EN = @[@"Sunday",@"Monday",@"Tuerday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    
    //获取当前设备语言
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    
    if ([languageName hasPrefix:@"zh-Hans"] || [languageName hasPrefix:@"zh-Hant"] || [languageName hasPrefix:@"zh-HK"] || [languageName hasPrefix:@"zh-TW"]) {
        if (CN.count > date.yj_weekday - 1) {
            return CN[date.yj_weekday - 1];
        }
    } else {
        if (EN.count > date.yj_weekday - 1) {
            return EN[date.yj_weekday - 1];
        }
    }
    return @"";
}

#pragma mark 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)yj_timeInfo {
    return [NSDate yj_timeInfoWithDate:self];
}

+ (NSString *)yj_timeInfoWithDate:(NSDate *)date {
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate yj_month] - [date yj_month]);
    int year = (int)([curDate yj_year] - [date yj_year]);
    int day = (int)([curDate yj_day] - [date yj_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate yj_month] == 1 && [date yj_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self yj_daysInMonth:date month:[date yj_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate yj_day] + (totalDays - (int)[date yj_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate yj_month];
            int preMonth = (int)[date yj_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

#pragma mark 指定月份的天数
- (NSUInteger)yj_daysInMonth:(NSUInteger)month {
    return [NSDate yj_daysInMonth:self month:month];
}

+ (NSUInteger)yj_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date yj_isLeapYear] ? 29 : 28;
    }
    return 30;
}

#pragma mark 时间戳格式转成日期字符串
+ (NSString *)yj_getDateStirngWithTimestamp:(NSString *)timestamp Format:(NSString *)format {
    NSTimeInterval interval = timestamp.length == 13 ? [timestamp doubleValue] / 1000.0f : [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate: date];
}

#pragma mark 时间转时间戳

+ (NSInteger)yj_timestamp:(NSDate *)date {return [date timeIntervalSince1970];}
- (NSInteger)yj_timestamp {return [NSDate yj_timestamp:self];}

#pragma mark 时间戳转时间
+ (NSDate *)yj_dateWithTimestamp:(NSInteger)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

#pragma mark 获取当前时间戳
+ (NSInteger)yj_currentTimestamp {return [self yj_timestamp:[NSDate date]];}

#pragma mark - String Properties
- (NSString *) yj_stringWithFormat: (NSString *) format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) yj_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) yj_shortString {
    return [self yj_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) yj_shortTimeString {
    return [self yj_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) yj_shortDateString {
    return [self yj_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) yj_mediumString {
    return [self yj_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) yj_mediumTimeString {
    return [self yj_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) yj_mediumDateString {
    return [self yj_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) yj_longString {
    return [self yj_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) yj_longTimeString {
    return [self yj_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) yj_longDateString {
    return [self yj_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) yj_isEqualToDateIgnoringTime: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) yj_isToday {
    return [self yj_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) yj_isTomorrow {
    return [self yj_isEqualToDateIgnoringTime:[NSDate yj_dateTomorrow]];
}

- (BOOL) yj_isYesterday {
    return [self yj_isEqualToDateIgnoringTime:[NSDate yj_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)yj_isSameWeekAsDate: (NSDate *) aDate {
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < YJ_D_WEEK);
    
}

- (BOOL) yj_isThisWeek {
    return [self yj_isSameWeekAsDate:[NSDate date]];
}

- (BOOL) yj_isNextWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yj_isSameWeekAsDate:newDate];
}

- (BOOL) yj_isLastWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - YJ_D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yj_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) yj_isSameMonthAsDate: (NSDate *) aDate {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#endif
    
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) yj_isThisMonth {
    return [self yj_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) yj_isLastMonth {
    return [self yj_isSameMonthAsDate:[[NSDate date] yj_dateBySubtractingMonths:1]];
}

- (BOOL) yj_isNextMonth {
    return [self yj_isSameMonthAsDate:[[NSDate date] yj_dateByAddingMonths:1]];
}

- (BOOL) yj_isSameYearAsDate: (NSDate *) aDate {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit  fromDate:aDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#endif
    return (components1.year == components2.year);
}

- (BOOL) yj_isThisYear {
    // Thanks, baspellis
    return [self yj_isSameYearAsDate:[NSDate date]];
}

- (BOOL) yj_isNextYear {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit  fromDate:[NSDate date]];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
#endif
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) yj_isLastYear {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit  fromDate:[NSDate date]];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
#endif
    return (components1.year == (components2.year - 1));
}

- (BOOL)yj_isLeapYear {return [NSDate yj_isLeapYear:self];}

+ (BOOL)yj_isLeapYear:(NSDate *)date {
    NSUInteger year = date.yj_year;
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (BOOL) yj_isEarlierThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) yj_isLaterThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) yj_isInFuture {
    return ([self yj_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) yj_isInPast {
    return ([self yj_isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) yj_isTypicallyWeekend {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate yj_currentCalendar] components:NSCalendarUnitWeekday | NSCalendarUnitMonth fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate yj_currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
#endif
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) yj_isTypicallyWorkday {
    return ![self yj_isTypicallyWeekend];
}

#pragma mark - Adjusting Dates
#pragma mark通过数字获取英文字符串月份
+ (NSString *)yj_monthWithMonthNumber:(NSInteger)month {
    if (month <= 0) {
        return @"";
    }
    NSArray *monthArray = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    if (monthArray.count > month - 1) {
        return monthArray[month - 1];
    }
    return @"";
}

// Thaks, rsjohnson
- (NSDate *) yj_dateByAddingYears: (NSInteger) dYears {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}



- (NSDate *) yj_dateByAddingMonths: (NSInteger) dMonths {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) yj_dateBySubtractingMonths: (NSInteger) dMonths {
    return [self yj_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) yj_dateByAddingDays: (NSInteger) dDays {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}


- (NSDate *) yj_dateByAddingHours: (NSInteger) dHours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + YJ_D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


- (NSDate *) yj_dateByAddingMinutes: (NSInteger) dMinutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + YJ_D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


- (NSDateComponents *) yj_componentsWithOffsetFromDate: (NSDate *) aDate {
    NSDateComponents *dTime = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

- (NSDate *) yj_dateAtStartOfDay {
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate yj_currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) yj_dateAtEndOfDay {
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate yj_currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) yj_minutesAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / YJ_D_MINUTE);
}

- (NSInteger) yj_minutesBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / YJ_D_MINUTE);
}

- (NSInteger) yj_hoursAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / YJ_D_HOUR);
}

- (NSInteger) yj_hoursBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / YJ_D_HOUR);
}

- (NSInteger) yj_daysAfterDate: (NSDate *) aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / YJ_D_DAY);
}

- (NSInteger) yj_daysBeforeDate: (NSDate *) aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / YJ_D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)yj_distanceDaysToDate:(NSDate *)anotherDate {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate yj_currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate yj_currentCalendar] components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    
    return components.day;
}

- (NSInteger)yj_distanceMonthsToDate:(NSDate *)anotherDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate yj_currentCalendar] components:NSCalendarUnitMonth fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate yj_currentCalendar] components:NSMonthCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:NSMonthCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    return components.month;
}
- (NSInteger)yj_distanceYearsToDate:(NSDate *)anotherDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    return components.year;
}
#pragma mark Decomposing Dates
- (NSInteger)yj_nearestHour {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate yj_currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate yj_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components =  [[NSDate yj_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
#endif
    return components.hour;
}

- (NSInteger) yj_hour {
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.hour;
}

- (NSInteger) yj_minute {
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.minute;
}

- (NSInteger) yj_seconds
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.second;
}

- (NSInteger) yj_day
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.day;
}

- (NSInteger) yj_month
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.month;
}

- (NSInteger) yj_week
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger) yj_weekday
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekday;
}

- (NSInteger) yj_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) yj_year
{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.year;
}

@end
