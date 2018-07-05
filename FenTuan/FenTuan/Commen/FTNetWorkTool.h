//  FTNetWorkTool.h
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlcok)(NSError* error);
@interface FTNetWorkTool : NSObject

+(instancetype)shareInstacne;

-(void)PostWithUrl:(NSString *)urlString
          paramter:(id)paramter
           success:(successBlock)success
           failure:(failureBlcok)failure;
-(void)GetWithUrl:(NSString *)urlString
         paramter:(id)paramter
          success:(successBlock)success
          failrue:(failureBlcok)failure;
@end
