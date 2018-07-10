//  FTBanaerCell.m
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTBanaerCell.h"
@interface FTBanaerCell()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *sd_view;
@end
@implementation FTBanaerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _sd_view.delegate = self;
}
+ (instancetype)advCellWithTableView:(UITableView *)tableView
{
    FTBanaerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setUrls:(NSArray *)urls{
    //这里设置一个占位图片了
    //_sdView.placeholderImage = [UIImage imageNamed:@""];
    NSLog(@"urls:%lu",(unsigned long)urls.count);
    _sd_view.imageURLStringsGroup = urls;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(FTBananerCellTapWithIndex:)]){
            [_delegate FTBananerCellTapWithIndex:index];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
