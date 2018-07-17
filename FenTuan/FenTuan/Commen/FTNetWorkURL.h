//  FTNetWorkURL.h
//  FenTuan
//  Created by bailing on 2018/7/4.
//  Copyright © 2018年 zhufeng. All rights reserved.
#ifndef FTNetWorkURL_h
#define FTNetWorkURL_h
///基本的请求url
#define FTBASE_URL      @"http://47.98.155.149:8088/lejiaokeji"
/*============================== 用户相关接口 =================================*/
///微信三方登录的URL
#define FT_WX_THIRD_URL @"https://api.weixin.qq.com/sns/oauth2/access_token"
///微信三方登录获取用户信息URL
#define FT_WX_USERINFO_URL @"https://api.weixin.qq.com/sns"
///登录URL
#define FT_LOGIN_URL     @"/user/login"
///获取验证码URL
#define FT_SENDCODE_URL  @"/user/sendCode"
///注册用户URL
#define FT_REGISTER_URL  @"/user/registAccount"
///忘记密码URL
#define FT_FORGETPWD_URL @"/user/findPassWord"
///微信绑定手机号码
#define FT_BINDPHONE_URL @"/user/bindPhone"
///修改密码
#define FT_UPWDATEPWD_URL @"/user/updatePassword"
///完善信息
#define FT_COMPLE_URL     @"/user/perfectInfo"
///分页查询
#define FT_FINPAGE_URL    @"/user/findPage"
/*============================== 首页接口 =================================*/
///首页的轮播URL
#define FT_HOME_BANAER_URL  @"/figure/getFigure"
///首页的推荐数据
#define FT_HOME_TUIJIAN_URL @"/shopList/sendJdData"
///
//http://47.98.155.149:8088/lejiaokeji/novice/sendData这个是新手推荐
//http://47.98.155.149:8088/lejiaokeji/market/sendMarket营销素材
//http://47.98.155.149:8088/lejiaokeji/jdTj/getJdTjData获取京东推荐
//http://47.98.155.149:8088/lejiaokeji/pddTj/getPddTjData平多多的推荐

#endif /* FTNetWorkURL_h */
