//
//  UITextField+YJInputLimit.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YJInputLimit)
@property (assign, nonatomic)  NSInteger yj_maxLength;//if <=0, no limit
@end
