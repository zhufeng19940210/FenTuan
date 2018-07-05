//  FTRegsiterVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTRegsiterVC.h"
#import "FTEditVC.h"
#import "FTAgreementVC.h"
#import "UIButton+countDown.h"
#import "FTEditVC.h"
@interface FTRegsiterVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UIButton *code_btn;
@property (weak, nonatomic) IBOutlet UIButton *agree_btn;
@property (nonatomic,copy)NSString *codeStr;
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
    [_tf_phone resignFirstResponder];
    [_tf_code resignFirstResponder];
    if (self.tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![FTUtil isMobileNumber:self.tf_phone.text]) {
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
#pragma mark 跳转到协议
- (IBAction)actionPushProtoclBtn:(UIButton *)sender
{
    FTAgreementVC *agreementvc = [[FTAgreementVC alloc]init];
    [self.navigationController pushViewController:agreementvc animated:YES];
}
#pragma mark  下一步
- (IBAction)ationNextBtn:(UIButton *)sender
{
    [_tf_phone resignFirstResponder];
    [_tf_code resignFirstResponder];
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
    if (![_tf_code.text isEqualToString:_codeStr]) {
        [SVProgressHUD showInfoWithStatus:@"验证码有误"];
        return;
    }
    FTEditVC *editvc = [[FTEditVC alloc]init];
    editvc.phone = _tf_phone.text;
    editvc.code  = _tf_code.text;
    editvc.isBindPhone = NO;
    [self.navigationController pushViewController:editvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
