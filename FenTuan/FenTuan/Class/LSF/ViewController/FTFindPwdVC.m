//  FTFindPwdVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTFindPwdVC.h"
#import "UIButton+countDown.h"
#import <SMS_SDK/SMSSDK.h> //短信
#import <SMS_SDK/SMSSDK+ContactFriends.h>
@interface FTFindPwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;
@end
@implementation FTFindPwdVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}
#pragma mark 获取验证码
- (IBAction)actionGetCodeBtn:(UIButton *)sender
{
    if (_tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if ([FTUtil isMobileNumber:_tf_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.tf_phone.text zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {   //获取验证码
            
            [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"秒" mainColor:       [UIColor darkGrayColor] countColor:[UIColor whiteColor]];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"获取验证码失败"];
        }
    }];
}
#pragma mark 确定修改
- (IBAction)acitonUpdatePwdBtn:(UIButton *)sender
{
    if (_tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (_tf_code.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return;
    }
    //验证验证码是否错误
    [SMSSDK commitVerificationCode:_tf_code.text phoneNumber:self.tf_phone.text zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            // 验证成功 发起注册请求
            [self updatePwd];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];
        }
    }];
}
#pragma mark --修改密码
-(void)updatePwd
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
