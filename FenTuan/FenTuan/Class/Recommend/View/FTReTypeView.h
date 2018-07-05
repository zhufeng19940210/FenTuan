//  FTReTypeView.h
//  FenTuan
//  Created by bailing on 2018/7/3.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>
@class FTReTypeView;
@protocol FTReTypeViewDelegate<NSObject>
-(void)FTReTypeViewClickTypeButton:(int)index;
@end;
//typedef void(^MyBtnBlock)(int index);
@interface FTReTypeView : UIView
//@property (nonatomic,copy) MyBtnBlock clickBlock;
@property(nonatomic,weak)id <FTReTypeViewDelegate>delegate;
@property (nonatomic,assign)int btnCurrentIndex;
@end
