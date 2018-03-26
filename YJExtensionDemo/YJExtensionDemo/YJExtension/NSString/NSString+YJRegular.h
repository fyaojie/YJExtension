//
//  NSString+YJRegular.h
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (YJRegular) // 正则验证

/**
 *  验证纯数字
 */
- (BOOL)yj_isOnlyNumber;
/**
 *  验证纯中文
 */
- (BOOL)yj_isOnlyChinese;

/**
 *  密码6-20为数字和字母组成
 */
- (BOOL)yj_validatePassword;

/**
 *  验证密码:数字+英文(大小写)
 */
- (BOOL)yj_isPwd;

/**
 *  验证密码:密码的内容限制  必须包含字母数字及特殊字符 长度为 6-16
 */
- (BOOL)yj_isPassword;

/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)yj_isMobileNumberClassification;
/**
 *  手机号有效性
 */
- (BOOL)yj_isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)yj_isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)yj_simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)yj_accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)yj_isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)yj_bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)yj_isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)yj_isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)yj_isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)yj_isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)yj_isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)yj_isValidTaxNo;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)yj_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)yj_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;


@end
