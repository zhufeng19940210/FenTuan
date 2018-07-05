//  FTUpdatePwdVC.m
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTUpdatePwdVC.h"
@interface FTUpdatePwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_oldpwd;
@property (weak, nonatomic) IBOutlet UITextField *tf_newpwd;
@property (weak, nonatomic) IBOutlet UITextField *tf_confimed;
@end
@implementation FTUpdatePwdVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 确认修改
- (IBAction)actionConfimBtn:(UIButton *)sender
{
    if ([_tf_oldpwd.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"旧密码不能为空"];
        return;
    }
    if ([_tf_newpwd.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"新密码不能为空"];
        return;
    }
    if ([_tf_confimed.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"再次输入密码"];
        return;
    }
    if (![_tf_newpwd.text isEqualToString:_tf_confimed.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次输入的密码不能为空"];
        return;
    }
    //开始去修改密码
    [SVProgressHUD show];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = @"";
    param[@"password"] = _tf_oldpwd.text;
    param[@"newPassWord"] = _tf_newpwd.text;
    param[@"confirmPassword"] = _tf_confimed.text;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@%@",FTBASE_URL,FT_UPWDATEPWD_URL] paramter:param success:^(id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
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
@end
