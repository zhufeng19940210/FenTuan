//  FTResponeModel.h
//  FenTuan
//
//  Created by bailing on 2018/7/4.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <Foundation/Foundation.h>
@interface FTHeaderModel : NSObject
@property (nonatomic,copy) NSString *message;
@property (nonatomic,assign) int retCode;
@end
@interface FTResponeModel : NSObject
@property (nonatomic,strong)FTHeaderModel *head;
@property (nonatomic,strong)id data;
@end
