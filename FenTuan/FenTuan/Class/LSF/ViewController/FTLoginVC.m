//  FTLoginVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTLoginVC.h"
#import "FTRegsiterVC.h"
#import "FTFindPwdVC.h"
#import "FTBindPhoneVC.h"
@interface FTLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;
@end
@implementation FTLoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = MainThemeColor;
    self.view.backgroundColor = MainThemeColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxLoginSuccess) name:@"wxlogin" object:nil];
}
-(void)wxLoginSuccess
{
    
}

#pragma mark 登录
- (IBAction)actionLoginBtn:(UIButton *)sender
{
    
}
#pragma mark 微信登录
- (IBAction)actionWeChatBtn:(UIButton *)sender
{
    ///step1:判断是否安装了客户端
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }
    else {
        [self setupAlertController];
    }
}
-(void)setupAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您先安装微信客户端?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark 手机注册
- (IBAction)actionRegisterBtn:(UIButton *)sender
{
    FTRegsiterVC *regsitervc = [[FTRegsiterVC alloc]init];
    [self.navigationController pushViewController:regsitervc animated:YES];
}
#pragma mark 忘记密码
- (IBAction)actionFindPwdBtn:(UIButton *)sender
{
    FTFindPwdVC *findpwdvc = [[FTFindPwdVC alloc]init];
    [self.navigationController pushViewController:findpwdvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
