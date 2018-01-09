//
//  TamTopView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSInteger(^TamTopCellNumBlock)(NSInteger section);//头部个数
typedef NSString *(^TamTopCellTitleBlock)(NSIndexPath *indexPath);//头部文字
typedef CGSize(^TamTopCellSizeBlock)(NSIndexPath *indexPath);//头部cell size
typedef UIColor *(^TamTopCellColorBlock)(NSIndexPath *indexPath);//头部颜色
typedef UIView *(^TamTopCellViewBlock)(NSIndexPath *indexPath);//头部添加视图

@protocol TamTopViewDelegate <NSObject>

@optional
-(void)changeTopScrollView:(UIScrollView *)topScrollView;

@end

@interface TamTopView : UIView

@property(nonatomic,weak)id<TamTopViewDelegate> delegate;
@property(nonatomic,weak)UICollectionView *collectionView;

@property(nonatomic,copy)TamTopCellNumBlock topCellNum;
@property(nonatomic,copy)TamTopCellTitleBlock topCellTitle;
@property(nonatomic,copy)TamTopCellSizeBlock topCellSize;
@property(nonatomic,copy)TamTopCellColorBlock topCellColor;
@property(nonatomic,copy)TamTopCellViewBlock topCellView;

@end

@interface TamTopCollectionCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *label;

@end
