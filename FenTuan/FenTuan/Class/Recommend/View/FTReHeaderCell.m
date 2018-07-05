//  FTReHeaderCell.m
//  FenTuan
//  Created by bailing on 2018/7/3.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "FTReHeaderCell.h"
@interface FTReHeaderCell()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *sdView;
@end

@implementation FTReHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _sdView.delegate = self;
}
-(void)setUrls:(NSArray *)urls
{
    _sdView.imageURLStringsGroup = urls;
}
+(instancetype)reHeaderCellWithTableView:(UITableView *)tableView
{
    FTReHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(FTReHeaderCellTapWithIndex:)]){
            [_delegate FTReHeaderCellTapWithIndex:index];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
