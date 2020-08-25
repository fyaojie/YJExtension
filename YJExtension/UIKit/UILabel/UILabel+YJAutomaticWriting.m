//
//  UILabel+YJAutomaticWriting.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import "UILabel+YJAutomaticWriting.h"
#import <objc/runtime.h>

NSTimeInterval const UILabelAWDefaultDuration = 0.4f;
unichar const UILabelAWDefaultCharacter = 124;

static inline void yj_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;

@implementation UILabel (YJAutomaticWriting)
@dynamic yj_automaticWritingOperationQueue, yj_edgeInsets;

#pragma mark - Public Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yj_AutomaticWritingSwizzleSelector([self class], @selector(textRectForBounds:limitedToNumberOfLines:), @selector(yj_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        yj_AutomaticWritingSwizzleSelector([self class], @selector(drawTextInRect:), @selector(yj_drawAutomaticWritingTextInRect:));
    });
}

-(void)yj_drawAutomaticWritingTextInRect:(CGRect)rect
{
    [self yj_drawAutomaticWritingTextInRect:UIEdgeInsetsInsetRect(rect, self.yj_edgeInsets)];
}

- (CGRect)yj_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self yj_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.yj_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setYj_edgeInsets:(UIEdgeInsets)edgeInsets
{
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)yj_edgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    
    if (edgeInsetsValue)
    {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return edgeInsetsValue.UIEdgeInsetsValue;
}

- (void)setYj_automaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue
{
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)yj_automaticWritingOperationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    
    if (operationQueue)
    {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return operationQueue;
}

- (void)yj_setTextWithAutomaticWritingAnimation:(NSString *)text
{
    [self yj_setText:text automaticWritingAnimationWithBlinkingMode:YJLinkingModeNone];
}

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(YJLinkingMode)blinkingMode
{
    [self yj_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration
{
    [self yj_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:YJLinkingModeNone];
}

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(YJLinkingMode)blinkingMode
{
    [self yj_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(YJLinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter
{
    [self yj_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(YJLinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion
{
    self.yj_automaticWritingOperationQueue.suspended = YES;
    self.yj_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    
    if (text)
    {
        [automaticWritingText appendString:text];
    }
    
    [self.yj_automaticWritingOperationQueue addOperationWithBlock:^{
        [self yj_automaticWriting:automaticWritingText duration:duration mode:blinkingMode character:blinkingCharacter completion:completion];
    }];
}

#pragma mark - Private Methods

- (void)yj_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(YJLinkingMode)mode character:(unichar)character completion:(void (^)(void))completion
{
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= YJLinkingModeWhenFinish) && !currentQueue.isSuspended)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != YJLinkingModeNone)
            {
                if ([self yj_isLastCharacter:character])
                {
                    [self yj_deleteLastCharacter];
                }
                else if (mode != YJLinkingModeWhenFinish || !text.length)
                {
                    [text insertString:[self yj_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length)
            {
                [self yj_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self yj_isLastCharacter:character] && mode == YJLinkingModeWhenFinishShowing) || (!text.length && mode == YJLinkingModeUntilFinishKeeping))
                {
                    [self yj_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended)
            {
                [currentQueue addOperationWithBlock:^{
                    [self yj_automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion)
            {
                completion();
            }
        });
    }
    else if (completion)
    {
        completion();
    }
}

- (NSString *)yj_stringWithCharacter:(unichar)character
{
    return [self yj_stringWithCharacters:@[@(character)]];
}

- (NSString *)yj_stringWithCharacters:(NSArray *)characters
{
    NSMutableString *string = NSMutableString.new;
    
    for (NSNumber *character in characters)
    {
        [string appendFormat:@"%C", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)yj_appendCharacter:(unichar)character
{
    [self yj_appendCharacters:@[@(character)]];
}

- (void)yj_appendCharacters:(NSArray *)characters
{
    self.text = [self.text stringByAppendingString:[self yj_stringWithCharacters:characters]];
}

- (BOOL)yj_isLastCharacters:(NSArray *)characters
{
    if (self.text.length >= characters.count)
    {
        return [self.text hasSuffix:[self yj_stringWithCharacters:characters]];
    }
    return NO;
}

- (BOOL)yj_isLastCharacter:(unichar)character
{
    return [self yj_isLastCharacters:@[@(character)]];
}

- (BOOL)yj_deleteLastCharacters:(NSUInteger)characters
{
    if (self.text.length >= characters)
    {
        self.text = [self.text substringToIndex:self.text.length-characters];
        return YES;
    }
    return NO;
}

- (BOOL)yj_deleteLastCharacter
{
    return [self yj_deleteLastCharacters:1];
}
@end
