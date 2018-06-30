//  FTGetCodeApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
/*
 获取验证码
 */
#import "YTKRequest.h"

@interface FTGetCodeApiParam: NSObject
///手机号码
@property (nonatomic,copy)NSString *phone;

@end

@interface FTGetCodeApi : YTKRequest

-(id)initWithParam:(FTGetCodeApiParam *)param;

@end
