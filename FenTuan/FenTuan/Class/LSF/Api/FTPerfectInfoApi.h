//  FTPerfectInfoApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
//
/*
 完善信息
 */

#import "YTKRequest.h"

@interface FTPerfectInfoApiParam : NSObject
///密码
@property (nonatomic,copy)NSString *password;
///手机号码
@property (nonatomic,copy)NSString *phone;
///邀请码
@property (nonatomic,copy)NSString *invitecode;
///用户昵称
@property (nonatomic,copy)NSString *nickname;
///地址
@property (nonatomic,copy)NSString *address;
///头像
@property (nonatomic,copy)NSString *headportrait;
///验证码
@property (nonatomic,copy)NSString *code;
///性别
@property (nonatomic,copy)NSString *sex;
///微信id
@property (nonatomic,copy)NSString *weixinid;

@end

@interface FTPerfectInfoApi : YTKRequest

-(id)initWithParam:(FTPerfectInfoApiParam *)param;

@end
