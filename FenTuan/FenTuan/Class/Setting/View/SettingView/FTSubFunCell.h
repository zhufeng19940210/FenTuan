//  FTSubFunCell.h
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
typedef void(^myItemBlock)(int index);
@interface FTSubFunCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)myItemBlock itemBlock;
@end

