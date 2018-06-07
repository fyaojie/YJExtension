//
//  UILabel+YJAutomaticWriting.h
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJLinkingMode)
{
    YJLinkingModeNone,
    YJLinkingModeUntilFinish,
    YJLinkingModeUntilFinishKeeping,
    YJLinkingModeWhenFinish,
    YJLinkingModeWhenFinishShowing,
    YJLinkingModeAlways
};

@interface UILabel (YJAutomaticWriting)
@property (strong, nonatomic) NSOperationQueue *yj_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets yj_edgeInsets;

- (void)yj_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(YJLinkingMode)blinkingMode;

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(YJLinkingMode)blinkingMode;

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(YJLinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)yj_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(YJLinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;
@end
