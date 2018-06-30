//  FTBindPhoneApi.m
//  FenTuan
//
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import "FTBindPhoneApi.h"

@implementation FTBindPhoneApiParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end

@implementation FTBindPhoneApi
{
    FTBindPhoneApiParam *_param;
}
-(id)initWithParam:(FTBindPhoneApiParam *)param
{
    self = [super init];
    if (self) {
        _param = param;
    }
    return self;
}
-(YTKRequestMethod )requestMethod
{
    return YTKRequestMethodGET;
}
-(NSString *)requestUrl
{
    return @"/user/bindPhone";
}
-(id)requestArgument
{
    NSDictionary *jsondData = [_param yy_modelToJSONObject];
    return jsondData;
}
@end
