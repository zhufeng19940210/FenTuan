//  FTRegsiterVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTRegsiterVC.h"
#import "FTEditVC.h"
#import "FTAgreementVC.h"
#import "UIButton+countDown.h"
#import <SMS_SDK/SMSSDK.h> //短信
#import <SMS_SDK/SMSSDK+ContactFriends.h>
#import "FTGetCodeApi.h"
@interface FTRegsiterVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UIButton *code_btn;
@property (weak, nonatomic) IBOutlet UIButton *agree_btn;
@end
@implementation FTRegsiterVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号注册";
}
#pragma mark 同意的按钮
- (IBAction)actionAgremmentBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.agree_btn setImage:[UIImage imageNamed:@"register_bt_agree_pr"] forState:UIControlStateNormal];
    }else{
        [self.agree_btn setImage:[UIImage imageNamed:@"register_bt_agree_def"] forState:UIControlStateNormal];
    }
}
#pragma mark 获取验证码
- (IBAction)actionGetCodeBtn:(UIButton *)sender
{
    if (self.tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![FTUtil isMobileNumber:self.tf_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    FTGetCodeApiParam *param = [[FTGetCodeApiParam alloc]init];
    param.phone = _tf_phone.text;
    
    FTGetCodeApi *api = [[FTGetCodeApi alloc]initWithParam:param];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"request:%@",request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD showErrorWithStatus:@"服务器请求失败"];
        return;
    }];
    [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"秒" mainColor:[UIColor darkGrayColor] countColor:[UIColor darkGrayColor]];
}
#pragma mark 跳转到协议
- (IBAction)actionPushProtoclBtn:(UIButton *)sender
{
    FTAgreementVC *agreementvc = [[FTAgreementVC alloc]init];
    [self.navigationController pushViewController:agreementvc animated:YES];
}
#pragma mark  下一步
- (IBAction)ationNextBtn:(UIButton *)sender
{
    if (self.tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![FTUtil isMobileNumber:self.tf_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    if (_tf_code.text.length ==  0 ) {
        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
        return;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
