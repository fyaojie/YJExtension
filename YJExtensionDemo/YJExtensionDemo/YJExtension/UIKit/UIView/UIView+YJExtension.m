//
//  UIView+YJExtension.m
//  YJExtensionDemo
//
//  Created by cool on 2018/5/31.
//  Copyright © 2018 child. All rights reserved.
//

#import "UIView+YJExtension.h"

@implementation UIView (YJExtension)

/**
 *  当前view所在的viewcontroler
 */
- (UIViewController *)yj_viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- (UIImage *)yj_screenshot {
    return [self yj_screenshot:0];
}

/**
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *  @param maxWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)yj_screenshot:(CGFloat)maxWidth{
    CGAffineTransform oldTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    
    //    if (!isnan(scale)) {
    //        CGAffineTransform transformScale = CGAffineTransformMakeScale(scale, scale);
    //        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
    //    }
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(self.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
        
    }
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        self.transform = scaleTransform;
    }
    
    CGRect actureFrame = self.frame; //已经变换过后的frame
    CGRect actureBounds= self.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, self.transform);
    CGPoint anchorPoint = self.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end
    self.transform = oldTransform;
    
    return screenshot;
}

@end
