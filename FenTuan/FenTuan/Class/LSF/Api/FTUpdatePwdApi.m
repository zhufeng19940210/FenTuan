//  FTUpdatePwdApi.m
//  FenTuan
//
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import "FTUpdatePwdApi.h"

@implementation FTUpdatePwdApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end

@implementation FTUpdatePwdApi
{
    FTUpdatePwdApiParam *_param;
}

-(id)initWithParam:(FTUpdatePwdApiParam *)param
{
    self = [super init];
    if (self) {
        _param = param;
    }
    return self;
}
-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}
-(NSString *)requestUrl
{
    return @"/user/updatePassword";
}
-(id)requestArgument
{
    return @{
             @"phone":_param.phone,
             @"newPassWord":_param.passWordN,
             @"password":_param.password,
             @"confirmPassword":_param.confirmPassword
             };
}
@end
