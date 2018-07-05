//  FTEditVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTEditVC.h"
@interface FTEditVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_invitate;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *headportrait;
@property (nonatomic,copy)NSString *weixinid;
@end
@implementation FTEditVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写信息";
    if (self.isBindPhone == YES) {
        //获取用户的信息
        [self getUserInfo];
    }
}
#pragma mark --获取信息
-(void)getUserInfo{
    
    WEAKSELF
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:FT_ACCESS_TOEKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:FT_OPENID];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", FT_WX_USERINFO_URL, accessToken, openID];
    NSLog(@"url:%@",userUrlStr);
    [manager GET:userUrlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
//        [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"city"] forKey:FT_CTIY];
//         [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"country"] forKey:FT_COUNTRY];
//         [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"headimgurl"] forKey:FT_HEADIMAGEURL];
//         [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"language"] forKey:FT_LANAUGAE];
//         [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"nickname"] forKey:FT_NICKNAME];
//         [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"province"] forKey:FT_PROVICEE];
//        [[NSUserDefaults standardUserDefaults]setValue:responseObject[@"sex"] forKey:FT_SEX];
        weakSelf.sex = responseObject[@"sex"];
        weakSelf.address = [NSString stringWithFormat:@"%@%@",responseObject[@"province"],responseObject[@"city"]];
        weakSelf.nickname = responseObject[@"nickname"];
        weakSelf.headportrait = responseObject[@"headimgurl"];
        weakSelf.weixinid = responseObject[@"openid"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
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
    if (self.isBindPhone == YES) {
         //微信信息
        [self wxLoginUserInfo];
    }else{
        ///正常的
        [self NormalLoginUserInfo];
    }
}
#pragma mark 微信信息的注册
-(void)wxLoginUserInfo{
    [SVProgressHUD show];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = self.phone;
    param[@"password"] = _tf_pwd.text;
    param[@"code"] = self.code;
    param[@"invitecode"] = _tf_invitate.text;
    param[@"sex"] = self.sex;
    param[@"nickname"] = self.nickname;
    param[@"address"]  = self.address;
    param[@"headportrait"] = self.headportrait;
    param[@"weixinid"] = self.weixinid;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@/user/registAccount",FTBASE_URL] paramter:param success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
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
#pragma mark 其他的功能
-(void)NormalLoginUserInfo
{
    [SVProgressHUD show];
    WEAKSELF
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = self.phone;
    param[@"password"] = _tf_pwd.text;
    param[@"code"] = self.code;
    param[@"invitecode"] = _tf_invitate.text;
    [[FTNetWorkTool shareInstacne]PostWithUrl:[NSString stringWithFormat:@"%@/user/registAccount",FTBASE_URL] paramter:param success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject:%@",responseObject);
        FTResponeModel *res = [FTResponeModel yy_modelWithDictionary:responseObject];
        if (res.head.retCode == 0) {
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
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
