//
//  TamLeftView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSInteger(^TamLeftCellNumBlock)(NSInteger section);//左边个数
typedef NSString *(^TamLeftCellTitleBlock)(NSIndexPath *indexPath);//左边文字
typedef CGSize(^TamLeftCellSizeBlock)(NSIndexPath *indexPath);//左边cell size
typedef UIColor *(^TamLeftCellColorBlock)(NSIndexPath *indexPath);//左边颜色
typedef UIView *(^TamLeftCellViewBlock)(NSIndexPath *indexPath);//左边添加视图

@protocol TamLeftViewDelegate <NSObject>

@optional
-(void)changeLeftScrollView:(UIScrollView *)leftScrollView;

@end

@interface TamLeftView : UIView

@property(nonatomic,weak)id<TamLeftViewDelegate> delegate;

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,copy)TamLeftCellNumBlock leftCellNum;
@property(nonatomic,copy)TamLeftCellTitleBlock leftCellTitle;
@property(nonatomic,copy)TamLeftCellSizeBlock leftCellSize;
@property(nonatomic,copy)TamLeftCellColorBlock leftCellColor;
@property(nonatomic,copy)TamLeftCellViewBlock leftCellView;

@end
