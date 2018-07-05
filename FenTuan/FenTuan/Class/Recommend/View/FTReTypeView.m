//  FTReTypeView.m
//  FenTuan
//  Created by bailing on 2018/7/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTReTypeView.h"
#import "ZFUpDownButton.h"
@interface FTReTypeView()
@property (weak, nonatomic) IBOutlet ZFUpDownButton *tuijianBtn;
@property (weak, nonatomic) IBOutlet ZFUpDownButton *yingxiaoBtn;
@property (weak, nonatomic) IBOutlet ZFUpDownButton *xinshouBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end
@implementation FTReTypeView
-(void)awakeFromNib
{
    [super awakeFromNib];
    _tuijianBtn.myButtonType = ButtonTypeImageUp;
    _yingxiaoBtn.myButtonType = ButtonTypeImageUp;
    _xinshouBtn.myButtonType = ButtonTypeImageUp;
}
#pragma mark 选择的东西
- (IBAction)actionSelectTypeBtn:(ZFUpDownButton *)sender
{
    NSLog(@"tag:%ld",(long)sender.tag);
    [self changeImageWithIndex:sender.tag];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(FTReTypeViewClickTypeButton:)]) {
            [self.delegate FTReTypeViewClickTypeButton:(int)sender.tag];
        }
    }
}
-(void)changeImageWithIndex:(int)index{
    if (index == 0) {
        _bgImageView.image = [UIImage imageNamed:@"recom_bg_01"];
        [_tuijianBtn setImage:[UIImage imageNamed:@"list_ic_underline"] forState:UIControlStateNormal];
        [_tuijianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_yingxiaoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_yingxiaoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_xinshouBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_xinshouBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }if (index == 1){
        _bgImageView.image = [UIImage imageNamed:@"recom_bg_02"];
        [_tuijianBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_tuijianBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_yingxiaoBtn setImage:[UIImage imageNamed:@"list_ic_underline"] forState:UIControlStateNormal];
        [_yingxiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_xinshouBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_xinshouBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }if (index == 2){
        _bgImageView.image = [UIImage imageNamed:@"recom_bg_03"];
        [_tuijianBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_tuijianBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_yingxiaoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_yingxiaoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_xinshouBtn setImage:[UIImage imageNamed:@"list_ic_underline"] forState:UIControlStateNormal];
        [_xinshouBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
-(void)setBtnCurrentIndex:(int)btnCurrentIndex
{
    [self changeImageWithIndex:btnCurrentIndex];
}
@end
