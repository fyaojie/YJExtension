//
//  NSArray+YJExtension.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YJExtension)

/* 数组便利 */
- (void)yj_each:(void (^)(id object, NSUInteger index))block;
/* 返回处理后的数据 */
- (NSArray *)yj_map:(id (^)(id object))block;
/* 返回条件满足的数据 */
- (NSArray *)yj_filter:(BOOL (^)(id object))block;
/* 返回条件满足以外的数据 */
- (NSArray *)yj_reject:(BOOL (^)(id object))block;
@end
