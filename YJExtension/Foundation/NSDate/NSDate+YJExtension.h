//
//  NSDate+YJExtension.h
//  分类研究
//
//  Created by 冯垚杰 on 2017/8/14.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJExtension)

+ (NSCalendar *)yj_currentCalendar; // avoid bottlenecks
#pragma mark ---- Decomposing dates 分解的日期
/// 最近的时间
@property (readonly) NSInteger yj_nearestHour;
/// 时
@property (readonly) NSInteger yj_hour;
/// 分
@property (readonly) NSInteger yj_minute;
/// 秒
@property (readonly) NSInteger yj_seconds;
/// 天
@property (readonly) NSInteger yj_day;
/// 月
@property (readonly) NSInteger yj_month;
/// 周 本月第几周
@property (readonly) NSInteger yj_week;

/**
 *  星期几 本周的第几个工作日
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
@property (readonly) NSInteger yj_weekday;
/// 表示WeekDay在下一个更大的日历单元中的位置。例如WeekDay=3，WeekDayOrdinal=2  就表示这个月的第2个周二。
@property (readonly) NSInteger yj_nthWeekday; // e.g. 2nd Tuesday of the month == 2
/// 年
@property (readonly) NSInteger yj_year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *yj_shortString;
@property (nonatomic, readonly) NSString *yj_shortDateString;
@property (nonatomic, readonly) NSString *yj_shortTimeString;
@property (nonatomic, readonly) NSString *yj_mediumString;
@property (nonatomic, readonly) NSString *yj_mediumDateString;
@property (nonatomic, readonly) NSString *yj_mediumTimeString;
@property (nonatomic, readonly) NSString *yj_longString;
@property (nonatomic, readonly) NSString *yj_longDateString;
@property (nonatomic, readonly) NSString *yj_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)yj_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)yj_stringWithFormat:(NSString *)format;

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
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)yj_timeInfo;
+ (NSString *)yj_timeInfoWithDate:(NSDate *)date;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)yj_daysInMonth:(NSUInteger)month;
+ (NSUInteger)yj_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 时间戳格式转成日期字符串
 
 @param timestamp 时间戳
 @param format    时间格式(如:yyyy-MM-dd)
 */
+ (NSString *)yj_getDateStirngWithTimestamp:(NSString *)timestamp Format:(NSString *)format;

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
#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)yj_dateTomorrow;
///昨天
+ (NSDate *)yj_dateYesterday;

///今天后几天 (今天前几天 请使用-)
+ (NSDate *)yj_dateWithDaysFromNow:(NSInteger)days;

///当前小时后dHours个小时 （当前小时前dHours个小时 请使用-）
+ (NSDate *)yj_dateWithHoursFromNow:(NSInteger)dHours;

///当前分钟后dMinutes个分钟 （当前分钟前dMinutes个分钟 请使用-）
+ (NSDate *)yj_dateWithMinutesFromNow:(NSInteger)dMinutes;



#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)yj_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)yj_isToday;
///是否是明天
- (BOOL)yj_isTomorrow;
///是否是昨天
- (BOOL)yj_isYesterday;

///是否是同一周
- (BOOL)yj_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)yj_isThisWeek;
///是否是本周的下周
- (BOOL)yj_isNextWeek;
///是否是本周的上周
- (BOOL)yj_isLastWeek;

///是否是同一月
- (BOOL)yj_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)yj_isThisMonth;
///是否是本月的下月
- (BOOL)yj_isNextMonth;
///是否是本月的上月
- (BOOL)yj_isLastMonth;

///是否是同一年
- (BOOL)yj_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)yj_isThisYear;
///是否是今年的下一年
- (BOOL)yj_isNextYear;
///是否是今年的上一年
- (BOOL)yj_isLastYear;
/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)yj_isLeapYear;
+ (BOOL)yj_isLeapYear:(NSDate *)date;


///是否早于aDate
- (BOOL)yj_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)yj_isLaterThanDate:(NSDate *)aDate;

///是否是未来
- (BOOL)yj_isInFuture;
///是否是过去
- (BOOL)yj_isInPast;


///是否是工作日
- (BOOL)yj_isTypicallyWorkday;
///是否是周末
- (BOOL)yj_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年（减少请使用-）
- (NSDate *)yj_dateByAddingYears:(NSInteger)dYears;

///增加dMonths月（减少请使用-）
- (NSDate *)yj_dateByAddingMonths:(NSInteger)dMonths;

///增加dDays天（减少请使用-）
- (NSDate *)yj_dateByAddingDays:(NSInteger)dDays;

///增加dHours小时（减少请使用-）
- (NSDate *)yj_dateByAddingHours:(NSInteger)dHours;

///增加dMinutes分钟（减少请使用-）
- (NSDate *)yj_dateByAddingMinutes:(NSInteger)dMinutes;



#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)yj_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)yj_minutesBeforeDate:(NSDate *)aDate;

///比aDate晚多少小时
- (NSInteger)yj_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)yj_hoursBeforeDate:(NSDate *)aDate;

///比aDate晚多少天
- (NSInteger)yj_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)yj_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)yj_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)yj_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)yj_distanceYearsToDate:(NSDate *)anotherDate;

@end
