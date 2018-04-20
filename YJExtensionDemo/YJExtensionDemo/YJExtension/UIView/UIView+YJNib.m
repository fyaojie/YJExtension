//
//  UIView+YJNib.m
//  YJExtensionDemo
//
//  Created by cool on 2018/4/20.
//  Copyright © 2018 child. All rights reserved.
//

#import "UIView+YJNib.h"

@implementation UIView (YJNib)
+ (instancetype)loadNib {
    return [self loadNibNamed:NSStringFromClass([self class])];
}
+ (instancetype)loadNibNamed:(NSString *)nibName {
    return [self loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}

+ (instancetype)loadNibNamed:(NSString *)nibName bundle:(NSBundle *)bundle {
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:nil options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
