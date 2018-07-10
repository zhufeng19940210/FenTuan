//  FTLoginVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTLoginVC.h"
#import "FTRegsiterVC.h"
#import "FTFindPwdVC.h"
#import "FTBindPhoneVC.h"
#import "FTEditVC.h"
@interface FTLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;
@end
@implementation FTLoginVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = MainThemeColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxLoginSuccess) name:FT_WXLOGINSUCCESS object:nil];
    ///ZF --测试账号
    _tf_phone.text = @"15070078339";
    _tf_pwd.text   = @"123456";
}
#pragma mark 微信登录
-(void)wxLoginSuccess
{
    FTBindPhoneVC *bindphonevc = [[FTBindPhoneVC alloc]init];
    [self.navigationController pushViewController:bindphonevc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark 登录
- (IBAction)actionLoginBtn:(UIButton *)sender
{
    if (_tf_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![FTUtil isMobileNumber:_tf_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号码有误"];
        return;
    }
    if (_tf_pwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    [SVProgressHUD show];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = _tf_phone.text;
    param[@"password"] = _tf_pwd.text;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_LOGIN_URL] paramter:param success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            FTUserModel *user = [FTUserModel yy_modelWithDictionary:res.data];
            [FTUserModel save:user];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            // 2.通过标识符找到对应的页面
            UIViewController *mainVc = [storyBoard instantiateViewControllerWithIdentifier:@"tabBar"];
            [UIApplication sharedApplication].delegate.window.rootViewController = mainVc;
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
