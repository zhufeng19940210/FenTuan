//  FTFindPwdVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTFindPwdVC.h"
#import "UIButton+countDown.h"
@interface FTFindPwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;
@property (nonatomic,copy) NSString *codeStr;
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
    [SVProgressHUD show];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = _tf_phone.text;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_SENDCODE_URL] paramter:param success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
            weakSelf.codeStr = res.data;
        }else{
            [SVProgressHUD showErrorWithStatus:res.head.message];
            return ;
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"服务器请求失败"];
        return;
    }];
    [sender startWithTime:59 title:@"获取验证码" countDownTitle:@"秒" mainColor:[UIColor darkGrayColor] countColor:[UIColor darkGrayColor]];
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
    if (![_tf_code.text isEqualToString:_codeStr]) {
        [SVProgressHUD showInfoWithStatus:@"验证码有误"];
        return;
    }
    if (_tf_pwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    //这个去请求
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = _tf_phone.text;
    param[@"code"] = _tf_code.text;
    param[@"password"] = _tf_pwd.text;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_FORGETPWD_URL] paramter:param success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:res.head.message];
            return;
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"服务器请求失败"];
        return;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
