//  AppDelegate.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "AppDelegate.h"
#import "FTLoginVC.h"
@interface AppDelegate ()<WXApiDelegate>
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ///初始化三方的东西
    [self setupBaseInitializeWithOptions];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    FTLoginVC *loginvc = [[FTLoginVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginvc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark 三方库的初始化
-(void)setupBaseInitializeWithOptions
{   //微信
    [WXApi registerApp:@"wx46b14ff64afefa78"];
    [Bugtags startWithAppKey:@"b7f0f5b36e8f02e6d2564bd2b7eb3938" invocationEvent:BTGInvocationEventBubble];
    //Network Config
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://47.98.155.149:8088";
    // SVProgressHUD
    //这里设置下样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    //设置背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    //设置前景色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //遮罩的颜色
    //[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    //设置遮罩的颜色
    //[SVProgressHUD setBackgroundLayerColor:[UIColor yellowColor]];
    //动画的样式(菊花)|默认是圆圈
    //[SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    //显示时间
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];//显示的时间
    //IQKeyboardManager
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
// 这个方法是用于从微信返回第三方App
//9.0的方法了
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
// 授权后回调
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        NSLog(@"resp:%@",resp);
        SendAuthResp *rep = (SendAuthResp *)resp;
        if (rep.errCode== 0) {
            NSLog(@"rep:%@",rep);
            AFHTTPSessionManager *manager =[AFHTTPSessionManager  manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"appid"] = @"";
            param[@"secret"] = @"";
            param[@"code"] = @"";
            param[@"grant_type"] = @"authorization_code";
            [manager GET:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"responseObject:%@",responseObject);
                //这里去获取那些字段的值
                //发送一个通知出去了
                [[NSNotificationCenter defaultCenter]postNotificationName:WXLOGINSUCCESS object:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD showErrorWithStatus:@"微信获取失败"];
                return;
            }];
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {

}
- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}
@end
