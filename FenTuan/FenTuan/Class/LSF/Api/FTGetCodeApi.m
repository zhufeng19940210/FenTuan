//  FTGetCodeApi.m
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "FTGetCodeApi.h"

@implementation FTGetCodeApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
@end

@implementation FTGetCodeApi
{
    FTGetCodeApiParam *_param;
}
-(id)initWithParam:(FTGetCodeApiParam *)param
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
    return  @"/user/sendCode";
}

-(id)requestArgument
{
    NSDictionary *jsonData = [_param yy_modelToJSONObject];
    return jsonData;
}

@end
