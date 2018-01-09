//
//  TamCenterView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark TamCenterView

typedef NSInteger(^TamCenterCellRowBlock)(NSInteger section);//有几行内容
typedef NSInteger(^TamCenterCellCollRowBlock)(NSInteger section);//每行有几列
typedef NSString *(^TamCenterCellTitleBlock)(NSInteger row,NSInteger col);//每行每列文字
typedef CGSize(^TamCenterCellSizeBlock)(NSInteger row,NSInteger col);//每个cell size
typedef UIColor *(^TamCenterCellColorBlock)(NSInteger row,NSInteger col);//每行每列的颜色
typedef UIView *(^TamCenterCellViewBlock)(NSInteger row,NSInteger col);//每行每列添加的视图

@protocol TamCenterViewDelegate<NSObject>

@optional
-(void)changeCenterXScrollView:(UIScrollView *)centerScrollView;
-(void)changeCenterYScrollView:(UIScrollView *)centerScrollView;

@end

@interface TamCenterView : UIView

@property(nonatomic,weak)id<TamCenterViewDelegate> delegate;
-(void)setPointWithScrollView:(UIScrollView *)scrollView type:(int)type;

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,copy)TamCenterCellRowBlock centerCellRow;
@property(nonatomic,copy)TamCenterCellCollRowBlock centerCellCollRow;
@property(nonatomic,copy)TamCenterCellTitleBlock centerCellTitle;
@property(nonatomic,copy)TamCenterCellSizeBlock centerCellSize;
@property(nonatomic,copy)TamCenterCellColorBlock centerCellColor;
@property(nonatomic,copy)TamCenterCellViewBlock centerCellView;

@end

#pragma mark TamCenterTableViewCell
typedef void(^TamContentViewCellDidScrollBlock)(UIScrollView *scrollView);
typedef NSString *(^TamCenterCollCellTitleBlock)(NSInteger col);//每个cell的主题
typedef CGSize(^TamCenterCollCellSizeBlock)(NSInteger col);//每个cell宽高
typedef UIColor *(^TamCenterCollCellColorBlock)(NSInteger col);//每个cell的颜色
typedef UIView *(^TamCenterCollCellViewBlock)(NSInteger col);//每个cell添加的视图

@interface TamCenterTableViewCell : UITableViewCell

+(instancetype)centerTableViewCellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)TamContentViewCellDidScrollBlock contentViewCellDidScrollBlock;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,copy)TamCenterCellCollRowBlock centerCellCollRow;
@property(nonatomic,copy)TamCenterCollCellTitleBlock centerCollCellTitle;
@property(nonatomic,copy)TamCenterCellTitleBlock centerCellTitle;
@property(nonatomic,copy)TamCenterCollCellSizeBlock centerCollCellSize;
@property(nonatomic,copy)TamCenterCollCellColorBlock centerCollCellColor;
@property(nonatomic,copy)TamCenterCollCellViewBlock centerCollCellView;

@end

#pragma mark TamCenterCollectionViewCell
@interface TamCenterCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *label;

@end
