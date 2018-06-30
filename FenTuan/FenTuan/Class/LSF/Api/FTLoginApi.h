//  FTLoginApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
/*
  用户登录
 */
#import "YTKRequest.h"

@interface FTLoginApiParam: NSObject
///手机号码
@property (nonatomic,copy)NSString *phone;
///密码
@property (nonatomic,copy)NSString *password;

@end

@interface FTLoginApi : YTKRequest

-(id)initWithParam:(FTLoginApiParam *)param;
@end
