//
//  NSObject+YJGCD.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/8.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YJGCD)
/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)yj_performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)yj_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)yj_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;
@end
