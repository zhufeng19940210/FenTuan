//  FTUserModel.m
//  FenTuan
//  Created by bailing on 2018/7/4.
//  Copyright © 2018年 zhufeng. All rights reserved
#import "FTUserModel.h"
static NSString *UserModelKey = @"UserModelKey";
@implementation FTUserModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
             @"userid":@"id",
             };
}
+(void)save:(FTUserModel *)model
{
    NSDictionary *user = model.mj_keyValues;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user forKey:UserModelKey];
    [defaults synchronize];
}
+(FTUserModel *)get
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults]valueForKey:UserModelKey];
    FTUserModel *model = [FTUserModel mj_objectWithKeyValues:dict];
    return model;
}

+(BOOL)isOnline
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:UserModelKey];
    FTUserModel *user =[FTUserModel mj_objectWithKeyValues:dict];
    if (user.phone.length>0)
        return YES;
    return NO;
}
+ (void)cleanUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserModelKey];
}
@end
