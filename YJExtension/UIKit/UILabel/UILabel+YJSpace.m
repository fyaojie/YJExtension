//
//  UILabel+YJSpace.m
//  YJExtensionDemo
//
//  Created by cool on 2018/6/7.
//  Copyright © 2018 child. All rights reserved.
//

#import "UILabel+YJSpace.h"

@implementation UILabel (YJSpace)
#pragma mark 改变行间距
- (void)yj_changeLineSpac:(float)space {
    [UILabel yj_changeLineSpaceForLabel:self WithSpace:space];
}
+ (void)yj_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    [UILabel yj_changeSpaceForLabel:label withLineSpace:space WordSpace:0];
}

#pragma mark 改变字间距
- (void)yj_changeWordSpace:(float)space {
    [UILabel yj_changeWordSpaceForLabel:self WithSpace:space];
}
+ (void)yj_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    [UILabel yj_changeSpaceForLabel:label withLineSpace:0 WordSpace:space];
}

#pragma mark 改变行间距和字间距
- (void)yj_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    [UILabel yj_changeSpaceForLabel:self withLineSpace:lineSpace WordSpace:wordSpace];
}
+ (void)yj_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
@end
