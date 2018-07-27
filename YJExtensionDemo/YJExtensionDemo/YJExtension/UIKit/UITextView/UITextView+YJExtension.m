//
//  UITextView+YJExtension.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/5.
//  Copyright © 2018 child. All rights reserved.
//

#import "UITextView+YJExtension.h"
#import <objc/runtime.h>

@implementation UITextView (YJExtension)

@end
static const void *YJTextViewInputLimitMaxLength = &YJTextViewInputLimitMaxLength;
@implementation UITextView (YJInputLimit)

- (NSInteger)yj_maxLength {
    return [objc_getAssociatedObject(self, YJTextViewInputLimitMaxLength) integerValue];
}
- (void)setYj_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, YJTextViewInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jk_textViewTextDidChange:)
                                                name:@"UITextViewTextDidChangeNotification" object:self];
    
}
- (void)jk_textViewTextDidChange:(NSNotification *)notification {
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

+ (void)load {
    [super load];
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(jk_textView_limit_swizzledDealloc));
    method_exchangeImplementations(origMethod, newMethod);
}
- (void)jk_textView_limit_swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self jk_textView_limit_swizzledDealloc];
}

@end

@implementation UITextView (YJSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)yj_selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}
/**
 *  @brief  选中所有文字
 */
- (void)yj_selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)yj_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


@end

static int yj_minFontSizeKey;
static int yj_maxFontSizeKey;
static int yj_zoomEnabledKey;
@implementation UITextView (YJPinchZoom)
- (void)setYj_maxFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &yj_maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yj_maxFontSize
{
    return [objc_getAssociatedObject(self, &yj_maxFontSizeKey) floatValue];
}

- (void)setYj_minFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &yj_minFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yj_minFontSize
{
    return [objc_getAssociatedObject(self, &yj_minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if (!self.isYj_zoomEnabled) return;
    
    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;
    
    pointSize = MAX(MIN(pointSize, self.yj_maxFontSize), self.yj_minFontSize);
    
    self.font = [UIFont fontWithName:self.font.fontName size:pointSize];
}

- (void)setYj_zoomEnabled:(BOOL)zoomEnabled
{
    objc_setAssociatedObject(self, &yj_zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;
        
        self.yj_minFontSize = self.yj_minFontSize ?: 8.0f;
        self.yj_maxFontSize = self.yj_maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
#if !__has_feature(objc_arc)
        [pinchRecognizer release];
#endif
    }
}

- (BOOL)isYj_zoomEnabled
{
    return [objc_getAssociatedObject(self, &yj_zoomEnabledKey) boolValue];
}
@end
