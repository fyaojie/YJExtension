//
//  NSObject+YJKVO.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^YJKVOBlock)(NSDictionary *change, void *context);
@interface NSObject (YJKVO)
/**
 添加观察者与监听属性
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block  监听回调
 */
- (void)yj_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(YJKVOBlock)block;
/**
 移除观察者对属性的监听
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 */
-(void)yj_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;

/**
 对象本身作为观察者
 
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block 监听回调
 */
-(void)yj_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(YJKVOBlock)block;

/**
 移除观察者对属性的监听
 
 @param keyPath 监听的属性
 */
-(void)yj_removeBlockObserverForKeyPath:(NSString *)keyPath;
@end
