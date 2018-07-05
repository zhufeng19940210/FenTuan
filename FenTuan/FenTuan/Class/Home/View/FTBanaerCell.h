//  FTBanaerCell.h
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
///点击的头部的视图
@protocol FTBanaerCellDelegate <NSObject>
-(void)FTBananerCellTapWithIndex:(NSInteger)index;
@end
@interface FTBanaerCell : UITableViewCell
@property (nonatomic,weak)id <FTBanaerCellDelegate> delegate;
@property (nonatomic,copy) NSArray *urls;
+ (instancetype)advCellWithTableView:(UITableView *)tableView;
@end
