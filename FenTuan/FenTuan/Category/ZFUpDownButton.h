//  ZFUpDownButton.h
//  GuomeiDemo
//  Created by bailing on 2018/6/12.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>
typedef enum {
    ButtonTypeImageTop,
    ButtonTypeImageUp
}MyButtonType;
@interface ZFUpDownButton : UIButton
@property (nonatomic,assign)MyButtonType myButtonType;
@end
