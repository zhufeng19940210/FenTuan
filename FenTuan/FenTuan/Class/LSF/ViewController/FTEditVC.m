//  FTEditVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTEditVC.h"
@interface FTEditVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_invitate;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;
@end
@implementation FTEditVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写信息";
}
#pragma mark 确定
- (IBAction)actionCommitBtn:(UIButton *)sender
{
    if (_tf_invitate.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"邀请码不能为空"];
        return;
    }
    if (_tf_name.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"昵称不能为空"];
        return;
    }
    if (_tf_pwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    //开始去注册
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
