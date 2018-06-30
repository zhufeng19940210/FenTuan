//  FTUpdatePwdApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.

/*
 修改密码
 */

#import "YTKRequest.h"

@interface FTUpdatePwdApiParam: NSObject
///手机号码
@property (nonatomic,copy)NSString *phone;
///新密码
@property (nonatomic,copy)NSString *passWordN;
///老密码
@property (nonatomic,copy)NSString *password;
///确认密码
@property (nonatomic,copy)NSString *confirmPassword;
@end

@interface FTUpdatePwdApi : YTKRequest

-(id)initWithParam:(FTUpdatePwdApiParam *)param;

@end
