//
//  TamLeftTopView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TamLeftTopViewDelegate <NSObject>

@optional
-(void)clickLeftTopView;

@end

@interface TamLeftTopView : UIView

@property(nonatomic,weak)id<TamLeftTopViewDelegate> delegate;
@property(nonatomic,assign)BOOL isCanTapLeftTop;
@property(nonatomic,strong)UILabel *topLabel;

@end
