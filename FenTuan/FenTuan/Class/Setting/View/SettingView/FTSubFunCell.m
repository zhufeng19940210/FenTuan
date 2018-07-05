//  FTSubFunCell.m
//  FenTuan
//  Created by bailing on 2018/7/2.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "FTSubFunCell.h"
#import "FTFunSubCell.h"
#import "FTTypeModel.h"
@interface FTSubFunCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
@implementation FTSubFunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCollectionView];
}
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
#pragma mark setupCollectionView
-(void)setupCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"FTFunSubCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FTFunSubCell"];
}
#pragma mark -- collectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView 
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FTTypeModel *model = self.dataArray[indexPath.row];
    FTFunSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FTFunSubCell" forIndexPath:indexPath];
    if (indexPath.row >=3) {
        cell.bottom_lab.hidden = YES;
    }
    cell.icon_image.image = [UIImage imageNamed:model.iconimagview];
    cell.title_lab.text = model.titleStr;
    cell.sub_title_sub.text = model.subTitleStr?model.subTitleStr:@"";
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemBlock) {
        self.itemBlock(indexPath.row);
    }
}
#pragma mark  - collectionFlowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = IPHONE_WIDTH / 3;
    return CGSizeMake(width,width);

}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
