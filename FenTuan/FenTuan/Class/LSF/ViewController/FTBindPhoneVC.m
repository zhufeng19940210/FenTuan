//  FTBindPhoneVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTBindPhoneVC.h"
#import "FTAgreementVC.h"
#import "UIButton+countDown.h"
#import <SMS_SDK/SMSSDK.h> //短信
#import <SMS_SDK/SMSSDK+ContactFriends.h>
@interface FTBindPhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UIButton *agrement_btn;
@end

@implementation FTBindPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
}

#pragma mark 同意的事件
- (IBAction)actionAgrementBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.agrement_btn setImage:[UIImage imageNamed:@"register_bt_agree_pr"] forState:UIControlStateNormal];
    }else{
        [self.agrement_btn setImage:[UIImage imageNamed:@"register_bt_agree_def"] forState:UIControlStateNormal];
    }
}
#pragma mark 用户协议
- (IBAction)actionPushBtn:(UIButton *)sender
{
    FTAgreementVC *agreementvc = [[FTAgreementVC alloc]init];
    [self.navigationController pushViewController:agreementvc animated:YES];
}

#pragma mark 获取验证码
- (IBAction)actionGetCodeBtn:(UIButton *)sender
{
    if (_tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![FTUtil isMobileNumber:_tf_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_tf_phone.text zone:@"86"  result:^(NSError *error) {
        
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
#pragma mark  确定的事件
- (IBAction)actionOKBtn:(UIButton *)sender
{
    if (_tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![FTUtil isMobileNumber:_tf_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    if (_tf_code.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
        return;
    }
    //验证验证码是否错误
    [SMSSDK commitVerificationCode:_tf_code.text phoneNumber:_tf_phone.text zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            // 验证成功 发起注册请求
            [self bindPhone];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];
        }
    }];
}
#pragma mark 绑定的方法
-(void)bindPhone
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
