//  FTFindPwdApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
/*
 找回密码
 */
#import "YTKRequest.h"

@interface FTFindPwdApiParam: NSObject
///手机号码
@property (nonatomic,copy)NSString *phone;
///验证码
@property (nonatomic,copy)NSString *code;
///新密码
@property (nonatomic,copy)NSString *password;

@end

@interface FTFindPwdApi : YTKRequest

-(id)initWithParam:(FTFindPwdApiParam *)param;

@end
