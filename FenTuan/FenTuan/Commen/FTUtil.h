//  FTUtil.h
//  FenTuan
//  Created by bailing on 2018/6/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <Foundation/Foundation.h>
// MD5 加密的东西
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
@interface FTUtil : NSObject
//  MD5加密
+ (NSString *)MD5:(NSString *)str;

// 利用正则表达式验证密码
+ (BOOL)isValidatPassword:(NSString *)text;

// 利用正则表达式验证全是空格
+ (BOOL)isValidateAllSpace:(NSString *)text;

// 利用正则表达式验证email
+ (BOOL)isValidateEmail:(NSString *)email;

// 判断是否有效身份证号码
+(BOOL)isValidIDNumber:(NSString*)idnumber;

// 利用正则表达式验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 利用正则表达式验证电信手机号码
+ (BOOL)isCTMobileNumber:(NSString *)mobileNum;

// 3DES加密解密
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString *)key;

//  保存，读取用户名、密码
+ (void)savePhone:(NSString *)phone andPwd:(NSString *)pwd;
+ (NSString *)getPhone;
+ (NSString *)getPwd;
+ (void)clearPhoneAndPwd;

+ (NSString*)getDocumentPath;
+ (NSString*)getDocumentFolderByName:(NSString *)foldername;

//时间戳转换成时间
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
///时间转换成时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//手机号码中间四位为****
+(NSString *)getPhoneWithXingWithPhone:(NSString *)phoneStr;

//压缩图片
+(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//照片获取本地路径转换
+(NSString *)getImagePath:(UIImage *)Image;
//获取文字的高度
+(CGSize)calculateTextSizeWithText:(NSString *)text
                      withTextFont:(NSInteger)textFont
                          wtihMaxW:(CGFloat)maxW;
@end
