//
//  UIView+YJGestureRecognizer.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (YJGestureRecognizer)

- (void)yj_addTapActionWithBlock:(GestureActionBlock)block;
- (void)yj_addLongPressActionWithBlock:(GestureActionBlock)block;

@end
