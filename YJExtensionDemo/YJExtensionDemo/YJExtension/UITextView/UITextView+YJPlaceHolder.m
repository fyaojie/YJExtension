//
//  UITextView+YJPlaceHolder.m
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import "UITextView+YJPlaceHolder.h"
#import <objc/runtime.h>

static const char *phTextView = "placeHolderTextView";

@implementation UITextView (YJPlaceHolder)

- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, phTextView);
}
- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)yj_placeHolder:(NSString *)placeHolder color:(UIColor*)color{
    if (![self placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = color?color:[UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        textView.hidden = self.text.length;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        self.placeHolderTextView.hidden = YES;
    }else{
        self.placeHolderTextView.hidden = NO;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}


@end
