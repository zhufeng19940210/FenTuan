//  FTPerfectInfoApi.m
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTPerfectInfoApi.h"

@implementation FTPerfectInfoApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
@end

@implementation FTPerfectInfoApi
{
    FTPerfectInfoApiParam *_param;
}
-(id)initWithParam:(FTPerfectInfoApiParam *)param
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
    return @"/user/perfectInfo";
}
-(id)requestArgument
{
    NSDictionary *jsonData = [_param yy_modelToJSONObject];
    return jsonData;
}
@end
