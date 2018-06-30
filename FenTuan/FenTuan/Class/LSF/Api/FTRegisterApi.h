//  FTRegisterApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.

/*
  用户注册
 */
#import "YTKRequest.h"

@interface FTRegisterApiParam: NSObject
///手机号码
@property (nonatomic,copy)NSString *phone;
///密码
@property (nonatomic,copy)NSString *password;
///验证码
@property (nonatomic,copy)NSString *code;
///邀请码
@property (nonatomic,copy)NSString *invitecode;

@end

@interface FTRegisterApi : YTKRequest

-(id)initWithParam:(FTRegisterApiParam *)param;

@end
