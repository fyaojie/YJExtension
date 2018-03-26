//
//  UIControl+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/17.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UIControl+YJExtension.h"
#import <objc/runtime.h>

#define UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(id x))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)(id x) = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block(sender);                                                                \
}                                                                           \
}

@implementation UIControl (YJExtension)

@end


@implementation UIControl (YJBlock)

UICONTROL_EVENT(yj_touchDown, TouchDown)
UICONTROL_EVENT(yj_touchDownRepeat, TouchDownRepeat)
UICONTROL_EVENT(yj_touchDragInside, TouchDragInside)
UICONTROL_EVENT(yj_touchDragOutside, TouchDragOutside)
UICONTROL_EVENT(yj_touchDragEnter, TouchDragEnter)
UICONTROL_EVENT(yj_touchDragExit, TouchDragExit)
UICONTROL_EVENT(yj_touchUpInside, TouchUpInside)
UICONTROL_EVENT(yj_touchUpOutside, TouchUpOutside)
UICONTROL_EVENT(yj_touchCancel, TouchCancel)
UICONTROL_EVENT(yj_valueChanged, ValueChanged)
UICONTROL_EVENT(yj_editingDidBegin, EditingDidBegin)
UICONTROL_EVENT(yj_editingChanged, EditingChanged)
UICONTROL_EVENT(yj_editingDidEnd, EditingDidEnd)
UICONTROL_EVENT(yj_editingDidEndOnExit, EditingDidEndOnExit)

@end
