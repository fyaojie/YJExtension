//
//  NSDate+YJExtension.m
//  分类研究
//
//  Created by 冯垚杰 on 2017/8/14.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "NSDate+YJExtension.h"
#import <UIKit/UIKit.h>

@implementation NSDate (YJExtension)

#pragma mark 日历组件
+ (NSCalendar *)yj_calendar {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 8.0) {
        //版本号大于等于8.0
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }
}

#pragma mark - 通过日历获取日期组件
+ (NSDateComponents *)yj_components:(NSDate *)date {    
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    
    NSDateComponents *dayComponents = [[NSDate yj_calendar] components:(NSCalendarUnitEra/*时代*/ | NSCalendarUnitYear/*年*/  | NSCalendarUnitMonth/*月*/  | NSCalendarUnitDay/*日*/  | NSCalendarUnitHour/*时*/  | NSCalendarUnitMinute/*分*/ | NSCalendarUnitSecond/*秒*/ | NSCalendarUnitWeekday/*星期*/ | NSCalendarUnitWeekdayOrdinal/*这个月的第几周*/ | NSCalendarUnitQuarter/*季度*/ | NSCalendarUnitWeekOfMonth/*这个月的第几个星期*/ | NSCalendarUnitWeekOfYear/*该年的第几个星期*/ | NSCalendarUnitYearForWeekOfYear | NSCalendarUnitNanosecond/*纳秒*/ | NSCalendarUnitCalendar | NSCalendarUnitTimeZone) fromDate:date];
#else
    
    NSDateComponents *dayComponents = [[NSDate yj_calendar] components:(NSEraCalendarUnit | NSYearCalendarUnit | NSCalendarUnitYear | NSMonthCalendarUnit | NSCalendarUnitMonth | NSDayCalendarUnit  | NSCalendarUnitDay | NSHourCalendarUnit |  | NSMinuteCalendarUnit | NSCalendarUnitMinute | NSSecondCalendarUnit | NSCalendarUnitSecond | NSWeekCalendarUnit | NSCalendarUnitWeekOfYear | NSWeekdayCalendarUnit | NSCalendarUnitWeekday | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit | NSCalendarUnitQuarter | NSWeekOfMonthCalendarUnit | NSCalendarUnitWeekOfYear | NSYearForWeekOfYearCalendarUnit | NSCalendarUnitYearForWeekOfYear | NSCalendarCalendarUnit | NSCalendarUnitCalendar | NSTimeZoneCalendarUnit) fromDate:date];
#endif
    return dayComponents;
}
- (NSDateComponents *)yj_components {return [NSDate yj_components:self];}


#pragma mark 年
- (NSUInteger)yj_year {return [NSDate yj_year:self];}
+ (NSUInteger)yj_year:(NSDate *)date { return [self yj_components:date].year;}

#pragma mark 月
- (NSUInteger)yj_month {return [NSDate yj_month:self];}
+ (NSUInteger)yj_month:(NSDate *)date { return [self yj_components:date].month;}

#pragma mark 星期
- (NSUInteger)yj_weekday {return [NSDate yj_weekday:self];}
+ (NSUInteger)yj_weekday:(NSDate *)date { return [self yj_components:date].weekday;}

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

#pragma mark 天
- (NSUInteger)yj_day {return [NSDate yj_day:self];}
+ (NSUInteger)yj_day:(NSDate *)date { return [self yj_components:date].day;}

#pragma mark 时
- (NSUInteger)yj_hour {return [NSDate yj_hour:self];}
+ (NSUInteger)yj_hour:(NSDate *)date { return [self yj_components:date].hour;}

#pragma mark 分
- (NSUInteger)yj_minute {return [NSDate yj_minute:self];}
+ (NSUInteger)yj_minute:(NSDate *)date { return [self yj_components:date].minute;}

#pragma mark 秒
- (NSUInteger)yj_second {return [NSDate yj_second:self];}
+ (NSUInteger)yj_second:(NSDate *)date { return [self yj_components:date].second;}

#pragma mark 是否是润年

- (BOOL)yj_isLeapYear {return [NSDate yj_isLeapYear:self];}

+ (BOOL)yj_isLeapYear:(NSDate *)date {
    NSUInteger year = date.yj_year;
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

#pragma mark 获取一年中的总天数

- (NSUInteger)yj_allDaysInYear {return [NSDate yj_allDaysInYear:self];}
+ (NSUInteger)yj_allDaysInYear:(NSDate *)date {return date.yj_isLeapYear ? 366 : 365;}


#pragma mark 格式化为YYYY-MM-dd格式的日期字符串
- (NSString *)yj_formatYMD {return [NSDate yj_formatYMD:self];}

+ (NSString *)yj_formatYMD:(NSDate *)date {return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)date.yj_year,(unsigned long)date.yj_month, (unsigned long)date.yj_day];}


#pragma mark 日期是否相等 (只判断年月日)
- (BOOL)yj_isSameDay:(NSDate *)anotherDate {
    return ([self.yj_components year] == [anotherDate.yj_components year]
            && [self.yj_components month] == [anotherDate.yj_components month]
            && [self.yj_components day] == [anotherDate.yj_components day]);
}

#pragma mark 是否是今天
- (BOOL)yj_isToday {return [self yj_isSameDay:[NSDate date]];}

#pragma mark 是否是昨天
- (BOOL)yj_isYesterday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    NSString *selfStr = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfStr];
    
    // 获得nowDate 和selfDate 的差距
    NSDateComponents *cmps = [[NSDate yj_calendar] components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

#pragma mark 是否为今年

- (BOOL)yj_isThisYear
{
    NSCalendar *calendar = [NSDate yj_calendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}


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

#pragma mark numHours小时后的日期
- (NSDate *)yj_dateAfterHours:(int)hours {
    return [NSDate yj_dateAfterHours:hours fromDate:self];
}

+ (NSDate *)yj_dateAfterHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {return nil;}

    NSDateComponents *dateAfterComponents = [[NSDateComponents alloc] init];
    [dateAfterComponents setHour:numHours];
    
    return [[NSDate yj_calendar] dateByAddingComponents:dateAfterComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark 返回day天后的日期(若day为负数,则为|day|天前的日期)

- (NSDate *)yj_dateAfterDay:(NSUInteger)day {return [NSDate yj_dateAfterDate:self day:day];}

+ (NSDate *)yj_dateAfterDate:(NSDate *)date day:(NSInteger)day {
     if (date == nil) {return nil;}
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    return [[NSDate yj_calendar] dateByAddingComponents:componentsToAdd toDate:date options:0];
}

#pragma mark numMonths月后的日期
- (NSDate *)yj_dateAfterMonths:(int)numMonths {
    return [NSDate yj_dateAfterMonths:numMonths fromDate:self];
}

+ (NSDate *)yj_dateAfterMonths:(int)numMonths fromDate:(NSDate *)fromDate {
     if (fromDate == nil) {return nil;}

    NSDateComponents *dateAfterComponents = [[NSDateComponents alloc] init];
    [dateAfterComponents setMonth:numMonths];
    
    return [[NSDate yj_calendar] dateByAddingComponents:dateAfterComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark numYears年后的日期
- (NSDate *)yj_dateAfterYears:(int)numYears {
    return [NSDate yj_dateAfterYears:numYears fromDate:self];
}

+ (NSDate *)yj_dateAfterYears:(int)numYears fromDate:(NSDate *)fromDate {
     if (fromDate == nil) {return nil;}

    NSDateComponents *dateAfterComponents = [[NSDateComponents alloc] init];
    [dateAfterComponents setYear:numYears];
    
    return [[NSDate yj_calendar] dateByAddingComponents:dateAfterComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark 获取该月的第一天的日期
- (NSDate *)yj_begindayOfMonth {
    return [NSDate yj_begindayOfMonth:self];
}

+ (NSDate *)yj_begindayOfMonth:(NSDate *)date {
    return [self yj_dateAfterDate:date day:-date.yj_day + 1];
}

#pragma mark 获取该月的最后一天的日期
- (NSDate *)yj_lastdayOfMonth {
    return [NSDate yj_lastdayOfMonth:self];
}

+ (NSDate *)yj_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self yj_begindayOfMonth:date];
    return [[lastDate yj_dateAfterMonths:1] yj_dateAfterDay:-1];
}

#pragma mark 该日期是该年的第几周
- (NSUInteger)yj_weekOfYear {
    return [NSDate yj_weekOfYear:self];
}

+ (NSUInteger)yj_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date yj_year];
    
    NSDate *lastdate = [date yj_lastdayOfMonth];
    
    for (i = 1;[[lastdate yj_dateAfterDay:-7 * i] yj_year] == year; i++) {
    }
    return i;
}

#pragma mark 当前月一共有几周(可能为4,5,6)
- (NSUInteger)yj_weeksOfMonth {
    return [NSDate yj_weeksOfMonth:self];
}

+ (NSUInteger)yj_weeksOfMonth:(NSDate *)date {
    return [[date yj_lastdayOfMonth] yj_weekOfYear] - [[date yj_begindayOfMonth] yj_weekOfYear] + 1;
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

#pragma mark 字符串转date
+ (NSDate *)yj_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

#pragma mark date转字符串
- (NSString *)yj_getDateStirngWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSString *)yj_getDateStirngWithDate:(NSDate *)date format:(NSString *)format {
    return [date yj_getDateStirngWithFormat:format];
}

#pragma mark 时间戳格式转成日期字符串
+ (NSString *)yj_getDateStirngWithTimestamp:(NSString *)timestamp Format:(NSString *)format {
    NSTimeInterval interval = timestamp.length == 13 ? [timestamp doubleValue] / 1000.0f : [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate: date];
}

#pragma mark 返回指定日期的date
+ (NSDate *)yj_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    [self zeroOutTimeComponents:&components];
    return [[NSDate yj_calendar] dateFromComponents:components];
}

+ (void)zeroOutTimeComponents:(NSDateComponents **)components {
    [*components setHour:0];
    [*components setMinute:0];
    [*components setSecond:0];
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
@end
