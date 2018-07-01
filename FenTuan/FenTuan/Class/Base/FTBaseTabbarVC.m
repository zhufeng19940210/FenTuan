//  FTBaseTabbarVC.m
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTBaseTabbarVC.h"
#import "FTHomeVC.h"
#import "FTRecommendVC.h"
#import "FTStoreVC.h"
#import "FTNoticeVC.h"
#import "FTSettingVC.h"
#import "FTLoginVC.h"
@interface FTBaseTabbarVC ()<UITabBarControllerDelegate>
@end
@implementation FTBaseTabbarVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    FTHomeVC      *homevc      = [[FTHomeVC alloc]init];
    FTRecommendVC *recommendvc = [[FTRecommendVC alloc]init];
    FTStoreVC     *stroevc     = [[FTStoreVC alloc]init];
    FTNoticeVC    *noticevc    = [[FTNoticeVC alloc]init];
    FTSettingVC   *settingvc   = [[FTSettingVC alloc]init];
    [self setupChilderWithController:homevc WithTitle:@"首页" WithnorImage:@"tab_ic_home_def" WithSelectImage:@"tab_ic_home_sel"];
    [self setupChilderWithController:recommendvc WithTitle:@"推荐" WithnorImage:@"tab_ic_recom_def" WithSelectImage:@"tab_ic_recom_sel"];
    [self setupChilderWithController:stroevc WithTitle:@"商城" WithnorImage:@"tab_ic_mall_def" WithSelectImage:@"tab_ic_mall_sel"];
    [self setupChilderWithController:noticevc WithTitle:@"通知" WithnorImage:@"tab_ic_inform_def" WithSelectImage:@"tabr_05_down"];
    [self setupChilderWithController:settingvc WithTitle:@"设置" WithnorImage:@"tab_ic_my_def" WithSelectImage:@"tab_ic_my_sel"];
}
-(void)setupChilderWithController:(UIViewController *)childVc  WithTitle:(NSString *)title WithnorImage:(NSString *)norImage WithSelectImage:(NSString *)seletImage{
    //childVc.title = title;
    UIImage *norImage2 = [UIImage imageNamed:norImage];
    childVc.tabBarItem.image = [norImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selelctImage2 = [UIImage imageNamed:seletImage];
    ///设置图片的偏移量
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
    childVc.tabBarItem.selectedImage = [selelctImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
#pragma makr 代理方法
///拦截跳转
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController == [tabBarController.viewControllers objectAtIndex:3]) {
        FTLoginVC *loginVc = [[FTLoginVC alloc]init];
        [self presentViewController:loginVc animated:YES completion:nil];
        return NO;
    }
    return YES;
}
@end
