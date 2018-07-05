//  FTUserModel.h
//  FenTuan
//  Created by bailing on 2018/7/4.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <Foundation/Foundation.h>

@interface FTUserModel : NSObject
///地址
@property (nonatomic,copy)NSString *address;
///commission
@property (nonatomic,copy)NSString *commission;
///earnings
@property (nonatomic,copy)NSString *earnings;
///头像
@property (nonatomic,copy)NSString *headportrait;
///id
@property (nonatomic,copy)NSString *userid;
///jdpid
@property (nonatomic,copy)NSString *jdpid;
///level
@property (nonatomic,copy)NSString *level;
///nickname
@property (nonatomic,copy)NSString *nickname;
///pddpid
@property (nonatomic,copy)NSString *pddpid;
///phone
@property (nonatomic,copy)NSString *phone;
///sex
@property (nonatomic,copy)NSString *sex;
///weixinNumber
@property (nonatomic,copy)NSString *weixinNumber;
//保存用户了
+ (void)save:(FTUserModel *)model;
//获取用户
+ (FTUserModel *)get;
//是否登录成功了
+ (BOOL)isOnline;
//清除登录信息
+ (void)cleanUserInfo;

@end
