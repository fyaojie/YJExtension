//
//  DataViewController.m
//  YJExtensionDemo
//
//  Created by cool on 2018/5/31.
//  Copyright © 2018 child. All rights reserved.
//

#import "DataViewController.h"
#import "YJExtension.h"


@interface DataViewController ()
@property (weak, nonatomic) IBOutlet UIButton *submittingButton;
@property (weak, nonatomic) IBOutlet UIButton *countDownButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DataViewController
- (IBAction)clickSubmittingButton:(UIButton *)sender {
    [sender yj_beginSubmitting:@"提交中。。。"];
}
- (IBAction)clickCountDownButton:(UIButton *)sender {
    [sender yj_startTime:60 title:@"获取验证码" waitTitle:@"倒计时"];
     
     [self.submittingButton yj_endSubmitting];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.textView.yj_maxFontSize = 30;
//    self.textView.yj_minFontSize = 5;
//    self.textView.yj_zoomEnabled = YES;
//    [self.textView yj_placeHolder:@"默认" color:[UIColor redColor]];
//    self.textView.yj_maxLength = 5;
//    [self.imageView jk_faceAwareFill];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.textView yj_setSelectedRange:NSMakeRange(0, 3)];
//    self.imageView.image = [self.imageView.image yj_watermarkWithImage:[UIImage imageNamed:@"1"] level:(YJWaterMarkLevel_right) vertical:(YJWaterMarkVertical_bottom)];
//    self.imageView.image = [self.imageView.image yj_watermarkWithText:@"cool" level:(YJWaterMarkLevel_right) vertical:(YJWaterMarkVertical_bottom) font:nil color:nil];
    
//    [self.label yj_setTextWithAutomaticWritingAnimation:@"这个是啥啥啥啥卡的挖的坑"];
//    [self.label jk_setText:@"这个是啥啥啥啥卡的挖的坑" automaticWritingAnimationWithDuration:5];
//    [self.label jk_setText:@"这个是啥啥啥啥卡的挖的坑" automaticWritingAnimationWithBlinkingMode:(UILabelJKlinkingModeAlways)];
    
//    [DataViewController jk_openAppReviewURLForIdentifier:1338674422];
//    [self jk_presentStoreKitItemWithIdentifier:1338674422];
//    [DataViewController jk_openAppURLForIdentifier:1338674422];
    [self yj_openAppURLForIdentifier:1338674422];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
