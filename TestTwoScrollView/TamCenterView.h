//
//  TamCenterView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TamCenterViewDelegate<NSObject>

@optional
-(void)changeCenterScrollView:(UIScrollView *)centerScrollView;

@end

@interface TamCenterView : UIView

@property(nonatomic,strong)id<TamCenterViewDelegate> delegate;
-(void)setPointWithScrollView:(UIScrollView *)scrollView type:(int)type;

@end
