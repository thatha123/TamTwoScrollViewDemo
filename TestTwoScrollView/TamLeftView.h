//
//  TamLeftView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TamLeftViewDelegate <NSObject>

@optional
-(void)changeLeftScrollView:(UIScrollView *)leftScrollView;

@end

@interface TamLeftView : UIView

@property(nonatomic,strong)id<TamLeftViewDelegate> delegate;

-(void)setPointWithScrollView:(UIScrollView *)scrollView;
-(void)setPoint:(CGPoint)p;

@end
