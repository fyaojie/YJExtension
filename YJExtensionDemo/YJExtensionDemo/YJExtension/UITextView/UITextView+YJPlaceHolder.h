//
//  UITextView+YJPlaceHolder.h
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (YJPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *placeHolderTextView;
/*
 * 设置显示的占位符和占位符颜色
 */
- (void)yj_placeHolder:(NSString *)placeHolder color:(UIColor*)color;
@end
