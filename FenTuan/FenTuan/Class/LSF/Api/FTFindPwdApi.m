//  FTFindPwdApi.m
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "FTFindPwdApi.h"

@implementation FTFindPwdApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
@end

@implementation FTFindPwdApi
{
    FTFindPwdApiParam *_param;
}
-(id)initWithParam:(FTFindPwdApiParam *)param
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
    return @"/user/findPassWord";
}
-(id)requestArgument
{
    NSDictionary *jsonData = [_param yy_modelToJSONObject];
    return jsonData;
}

@end

