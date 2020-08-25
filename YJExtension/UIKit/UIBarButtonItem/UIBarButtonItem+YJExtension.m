//
//  UIBarButtonItem+YJExtension.m
//  YJBaseProject
//
//  Created by 冯垚杰 on 2017/8/19.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import "UIBarButtonItem+YJExtension.h"
#import <UIImage+YJExtension.h>
#import <UIControl+YJExtension.h>

@implementation UIBarButtonItem (YJExtension)

+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    //    [buttonView addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)createBageValueNoticeButtonWithBageValue:(NSInteger)bageValue
                                                       target:(id)target
                                                       action:(SEL)action{
    
    if (bageValue <= 0) {
        return [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"h_notice"] highlightedImage:[UIImage imageNamed:@"h_notice"] target:target action:action];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 18, 18);
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setImage:[UIImage imageNamed:@"h_notice"] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIView *rightBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBgView addSubview:button];
    button.center = rightBgView.center;
    
    if (bageValue <= 0) {
        
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(rightBgView.frame)/2, 0, CGRectGetWidth(rightBgView.frame)/2, CGRectGetHeight(rightBgView.frame)/3)];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.clipsToBounds = YES;
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = CGRectGetHeight(rightBgView.frame)/6;
        [rightBgView addSubview:label];
        if (bageValue > 99) {
            label.text = @"99+";
        } else {
            label.text = [NSString stringWithFormat:@"%ld",(long)bageValue];
        }
    }
    
    UIImage *image;// = ;//[UIImage yj_imageFromView:rightBgView];
    
    return [UIBarButtonItem createItemWithImage:image highlightedImage:image target:target action:action];
}

/** 图标UIBarButtonItem */
+ (instancetype)yj_itemWithType:(YJItemType)type norImage:(NSString *)norImage highImage:(NSString *)highImage offset:(CGFloat)offset actionHandler:(YJTouchedBarButtonItemBlock)touchHandler {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = type == YJItemTypeLeft ? UIEdgeInsetsMake(0, -offset, 0, 0) : UIEdgeInsetsMake(0, 0, 0, -offset);
    [btn sizeToFit];
    // 添加按钮点击事件
    [btn yj_touchUpInside:^(UIButton *sender) {
        if (touchHandler) touchHandler(sender);
    }];
    UIView *containVew = [[UIView alloc] initWithFrame:btn.bounds];
    [containVew addSubview:btn];
    return [[self alloc] initWithCustomView:containVew];
}

/** 文字UIBarButtonItem */
+ (instancetype)yj_itemWithType:(YJItemType)type norTitle:(NSString *)norTitle font:(CGFloat)font norColor:(UIColor *)norColor highColor:(UIColor *)highColor offset:(CGFloat)offset actionHandler:(YJTouchedBarButtonItemBlock)touchHandler {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:norTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:norColor forState:UIControlStateNormal];
    [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = type == YJItemTypeLeft ? UIEdgeInsetsMake(0, -offset, 0, 0) : UIEdgeInsetsMake(0, 0, 0, -offset);
    [btn sizeToFit];
    // 添加按钮点击事件
    [btn yj_touchUpInside:^(UIButton *sender) {
        if (touchHandler) touchHandler(sender);
    }];
    UIView *containVew = [[UIView alloc] initWithFrame:btn.bounds];
    [containVew addSubview:btn];
    return [[self alloc] initWithCustomView:containVew];
}

@end
