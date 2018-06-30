//  FTRegisterApi.m
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "FTRegisterApi.h"

@implementation FTRegisterApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end

@implementation FTRegisterApi
{
    FTRegisterApiParam *_param;
}
-(id)initWithParam:(FTRegisterApiParam *)param
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
    return @"/user/registAccount";
}
-(id)requestArgument
{
    NSDictionary *jsonData = [_param yy_modelToJSONObject];
    return jsonData;
}
@end
