//  FTNetWorkTool.m
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTNetWorkTool.h"
static FTNetWorkTool *tool = nil;
AFHTTPSessionManager *session = nil;
@implementation FTNetWorkTool
+(instancetype)shareInstacne{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[FTNetWorkTool alloc]init];
        session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        session.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;//去除空值
        session.responseSerializer = response;//申明返回的结果是json
    });
    return tool;
}
-(void)PostWithUrl:(NSString *)urlString paramter:(id)paramter success:(successBlock)success failure:(failureBlcok)failure{
    [session POST:urlString parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

-(void)GetWithUrl:(NSString *)urlString paramter:(id)paramter success:(successBlock)success failrue:(failureBlcok)failure{
    [session GET:urlString parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}
@end
