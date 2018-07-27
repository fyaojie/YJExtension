//
//  UITextField+YJInputLimit.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import "UITextField+YJInputLimit.h"
#import <objc/runtime.h>

static const void *YJTextFieldInputLimitMaxLength = &YJTextFieldInputLimitMaxLength;
@implementation UITextField (YJInputLimit)
- (NSInteger)yj_maxLength {
    return [objc_getAssociatedObject(self, YJTextFieldInputLimitMaxLength) integerValue];
}
- (void)setYj_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, YJTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(yj_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)yj_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.yj_maxLength > 0 && toBeString.length > self.yj_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.yj_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.yj_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.yj_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.yj_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
