//  FTBindPhoneApi.h
//  FenTuan
//  Created by bailing on 2018/6/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
/*
 绑定手机号码
 */

#import "YTKRequest.h"

@interface FTBindPhoneApiParam :NSObject
///微信的id
@property (nonatomic,copy)NSString *weixinid;

@end

@interface FTBindPhoneApi : YTKRequest

-(id)initWithParam:(FTBindPhoneApiParam *)param;

@end
