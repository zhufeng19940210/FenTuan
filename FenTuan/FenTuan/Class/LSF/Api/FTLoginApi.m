//  FTLoginApi.m
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import "FTLoginApi.h"

@implementation FTLoginApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
@end

@implementation FTLoginApi
{
    FTLoginApiParam *_param;
}
-(id)initWithParam:(FTLoginApiParam *)param
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
    return  @"/user/login";
}
-(id)requestArgument
{
    NSDictionary *jsonData = [_param yy_modelToJSONObject];
    return jsonData;
}
@end
