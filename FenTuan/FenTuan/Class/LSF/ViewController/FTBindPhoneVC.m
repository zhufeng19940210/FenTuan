//  FTBindPhoneVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTBindPhoneVC.h"
#import "FTAgreementVC.h"
#import "UIButton+countDown.h"
#import "FTEditVC.h"
@interface FTBindPhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UIButton *agrement_btn;
@property (nonatomic,copy)  NSString *codeStr;
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
    [SVProgressHUD showWithStatus:@"正在获取"];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = _tf_phone.text;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_SENDCODE_URL] paramter:param success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
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
    if (![_tf_code.text isEqualToString:_codeStr]) {
        [SVProgressHUD showInfoWithStatus:@"验证码有误"];
        return;
    }
    //绑定手机号码的方法
    [SVProgressHUD showWithStatus:@"正在绑定"];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *wexinid = [[NSUserDefaults standardUserDefaults]valueForKey:FT_OPENID];
    NSLog(@"wexinid:%@",wexinid);
    param[@"weixinid"] = wexinid;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_BINDPHONE_URL] paramter:param success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0 || res.head.retCode == 18) {
            FTEditVC *editvc = [[FTEditVC alloc]init];
            editvc.phone = _tf_phone.text;
            editvc.code  = _tf_code.text;
            editvc.isBindPhone = YES;
            [weakSelf.navigationController pushViewController:editvc animated:YES];
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
