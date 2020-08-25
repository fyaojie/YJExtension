//
//  NSObject+YJKVO.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/11.
//  Copyright © 2018 child. All rights reserved.
//

#import "NSObject+YJKVO.h"
#import <objc/runtime.h>

@implementation NSObject (YJKVO)
-(void)yj_addObserver:(NSObject *)observer
           forKeyPath:(NSString *)keyPath
              options:(NSKeyValueObservingOptions)options
              context:(void *)context
            withBlock:(YJKVOBlock)block {
    
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

-(void)yj_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    YJKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    if (block) {
        block(change, context);
    }
}

-(void)yj_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(YJKVOBlock)block {
    
    [self yj_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

-(void)yj_removeBlockObserverForKeyPath:(NSString *)keyPath {
    [self yj_removeBlockObserver:self forKeyPath:keyPath];
}
@end
