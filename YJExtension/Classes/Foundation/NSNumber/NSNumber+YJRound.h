//
//  NSNumber+YJRound.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (YJRound)
/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)yj_doRoundWithDigit:(NSUInteger)digit;
/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)yj_doCeilWithDigit:(NSUInteger)digit;
/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)yj_doFloorWithDigit:(NSUInteger)digit;
@end
