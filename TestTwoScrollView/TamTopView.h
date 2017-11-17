//
//  TamTopView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TamTopViewDelegate <NSObject>

@optional
-(void)changeTopScrollView:(UIScrollView *)topScrollView;

@end

@interface TamTopView : UIView

@property(nonatomic,strong)id<TamTopViewDelegate> delegate;
-(void)setPointWithScrollView:(UIScrollView *)scrollView;
-(void)setPoint:(CGPoint)p;

@end

@interface TamTopCollectionCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *label;

@end
