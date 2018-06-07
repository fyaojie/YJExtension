//
//  NSDate+YJExtension.h
//  分类研究
//
//  Created by 冯垚杰 on 2017/8/14.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJExtension)

//*********************************************** 获取某个date下的数据 ********************************************************

/**
 日历组件
 */
+ (NSCalendar *)yj_calendar;
/**
 日期组件
 */
+ (NSDateComponents *)yj_components:(NSDate *)date;
- (NSDateComponents *)yj_components;

/**
 年
 */
- (NSUInteger)yj_year;
+ (NSUInteger)yj_year:(NSDate *)date;

/**
 月
 */
- (NSUInteger)yj_month;
+ (NSUInteger)yj_month:(NSDate *)date;

/**
 *  获取星期几(数字)
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSUInteger)yj_weekday;
+ (NSUInteger)yj_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)yj_weekdayString;
+ (NSString *)yj_weekdayString:(NSDate *)date;

/**
 日
 */
- (NSUInteger)yj_day;
+ (NSUInteger)yj_day:(NSDate *)date;

/**
 小时
 */
- (NSUInteger)yj_hour;
+ (NSUInteger)yj_hour:(NSDate *)date;

/**
 分钟
 */
- (NSUInteger)yj_minute;
+ (NSUInteger)yj_minute:(NSDate *)date;

/**
 秒
 */
- (NSUInteger)yj_second;
+ (NSUInteger)yj_second:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)yj_isLeapYear;
+ (BOOL)yj_isLeapYear:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)yj_allDaysInYear;
+ (NSUInteger)yj_allDaysInYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)yj_formatYMD;
+ (NSString *)yj_formatYMD:(NSDate *)date;

/**
 *  日期是否相等(只判断年月日)
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)yj_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)yj_isToday;

/**
 *  是否为昨天
 */
- (BOOL)yj_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)yj_isThisYear;
/**
 *  通过数字获取英文字符串月份
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)yj_monthWithMonthNumber:(NSInteger)month;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)yj_dateAfterHours:(int)hours;
+ (NSDate *)yj_dateAfterHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)yj_dateAfterDay:(NSUInteger)day;
+ (NSDate *)yj_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)yj_dateAfterMonths:(int)numMonths;
+ (NSDate *)yj_dateAfterMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)yj_dateAfterYears:(int)numYears;
+ (NSDate *)yj_dateAfterYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)yj_begindayOfMonth;
+ (NSDate *)yj_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)yj_lastdayOfMonth;
+ (NSDate *)yj_lastdayOfMonth:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)yj_weekOfYear;
+ (NSUInteger)yj_weekOfYear:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)yj_weeksOfMonth;
+ (NSUInteger)yj_weeksOfMonth:(NSDate *)date;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)yj_daysInMonth:(NSUInteger)month;
+ (NSUInteger)yj_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)yj_timeInfo;
+ (NSString *)yj_timeInfoWithDate:(NSDate *)date;


/**
 字符串转date

 @param string 日期的字符串
 @param format 匹配的类型 例如：yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式

 */
+ (NSDate *)yj_dateWithString:(NSString *)string format:(NSString *)format;


/**
 date转字符串

 @param format 匹配的类型 例如：yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式
 */
- (NSString *)yj_getDateStirngWithFormat:(NSString *)format;
+ (NSString *)yj_getDateStirngWithDate:(NSDate *)date format:(NSString *)format;

/**
 时间戳格式转成日期字符串
 
 @param timestamp 时间戳
 @param format    时间格式(如:yyyy-MM-dd)
 */
+ (NSString *)yj_getDateStirngWithTimestamp:(NSString *)timestamp Format:(NSString *)format;

/**
 返回指定日期的date
 
 @param year 指定的年
 @param month 指定的月
 @param day 指定的天
 */
+ (NSDate *)yj_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


/**
 date转时间戳

 @return 时间戳 (秒)
 */
- (NSInteger)yj_timestamp;
+ (NSInteger)yj_timestamp:(NSDate *)date;


/**
 时间戳转时间

 @param timestamp 时间戳 (秒)
 */
+ (NSDate *)yj_dateWithTimestamp:(NSInteger)timestamp;

/**
 获取当前时间戳 (秒)
 */
+ (NSInteger)yj_currentTimestamp;

@end
