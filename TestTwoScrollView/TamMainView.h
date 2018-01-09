//
//  TamMainView.h
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TamMainView;
@protocol TamMainViewDataSource<NSObject>

@required
<<<<<<< HEAD
/**
 @param mainView TamMainView
 @param section 暂时没用到
 @return 返回表格有多少行(左侧有几列)
 */
-(NSInteger)mainView:(TamMainView *)mainView numberOfRowsInSection:(NSInteger)section;
/**
 @param mainView TamMainView
 @param section 暂时没用到
 @return 返回表格有多少列(顶部有几行)
 */
-(NSInteger)mainView:(TamMainView *)mainView numberOfColsInSection:(NSInteger)section;
/**
 @param mainView TamMainView
 @param row 行
 @param col 列
 @return 返回表格某行某列位置上需要显示的内容
 */
-(NSString *)mainView:(TamMainView *)mainView cellForCenterTitleAtRow:(NSInteger)row col:(NSInteger)col;
/**
 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格左侧标题列每行需要显示的内容
 */
-(NSString *)mainView:(TamMainView *)mainView cellForLeftTitleAtIndexPath:(NSIndexPath*)indexPath;
/**
 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格顶部标题行每列需要显示的内容
 */
=======
//返回表格有多少行(左侧有几列)
-(NSInteger)mainView:(TamMainView *)mainView numberOfRowsInSection:(NSInteger)section;
//返回表格有多少列(顶部有几行)
-(NSInteger)mainView:(TamMainView *)mainView numberOfColsInSection:(NSInteger)section;
//返回表格某行某列位置上需要显示的内容 indexRow行 col每行的列
-(NSString *)mainView:(TamMainView *)mainView cellForCenterTitleAtRow:(NSInteger)row col:(NSInteger)col;
//返回表格左侧标题列每行需要显示的内容
-(NSString *)mainView:(TamMainView *)mainView cellForLeftTitleAtIndexPath:(NSIndexPath*)indexPath;
//返回表格上边标题行每列需要显示的内容
>>>>>>> origin/master
-(NSString *)mainView:(TamMainView *)mainView cellForTopTitleAtIndexPath:(NSIndexPath*)indexPath;

@optional

@end

@protocol TamMainViewDelegate<NSObject>
@optional
<<<<<<< HEAD
/**
 @param mainView TamMainView
 @param col 列
 @return 返回表格每列的宽
 */
-(CGFloat)mainView:(TamMainView *)mainView widthForCenterAtCol:(NSInteger)col;
/**
 @param mainView TamMainView
 @param row 行
 @return 返回表格每行的高
 */
-(CGFloat)mainView:(TamMainView *)mainView heightForCenterAtRow:(NSInteger)row;
/**
 【isAutoSize为NO时才有效。默认YES，根据heightForCenterAtRow返回】

 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格左侧的高
 */
-(CGFloat)mainView:(TamMainView *)mainView heightForLeftCellIndexPath:(NSIndexPath *)indexPath;
/**
 @param mainView TamMainView
 @return 返回表格左侧的宽
 */
-(CGFloat)widthForLeftCellWithMainView:(TamMainView *)mainView;
/**
 【isAutoSize为NO时才有效。默认YES，根据widthForCenterAtCol返回】
 
 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格顶部的宽
 */
-(CGFloat)mainView:(TamMainView *)mainView widthForTopCellIndexPath:(NSIndexPath *)indexPath;
/**
 @param mainView TamMainView
 @return 返回表格顶部的高
 */
-(CGFloat)heightForTopCellWithMainView:(TamMainView *)mainView;

/**
 @param mainView TamMainView
 @param row 行
 @param col 列
 @return 返回表格每行每列的颜色
 */
-(UIColor *)mainView:(TamMainView *)mainView colorForCenterAtRow:(NSInteger)row col:(NSInteger)col;
/**
 【isAutoColor为NO时才有效。默认YES，根据colorForCenterAtRow返回】

 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格左侧颜色
 */
-(UIColor *)mainView:(TamMainView *)mainView colorForLeftCellIndexPath:(NSIndexPath *)indexPath;
/**
 没有返回时默认取colorForCenterAtRow颜色的内容的下标1的颜色
 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格头部颜色
 */
-(UIColor *)mainView:(TamMainView *)mainView colorForTopCellIndexPath:(NSIndexPath *)indexPath;

/**
 @param mainView TamMainView
 @param row 行
 @param col 列
 @return 返回表格每行每列的视图
 */
-(UIView *)mainView:(TamMainView *)mainView viewForCenterAtRow:(NSInteger)row col:(NSInteger)col;
/**
 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格左侧的视图
 */
-(UIView *)mainView:(TamMainView *)mainView viewForLeftCellIndexPath:(NSIndexPath *)indexPath;
/**
 @param mainView TamMainView
 @param indexPath indexPath.row
 @return 返回表格头部的视图
 */
=======
//返回表格每行每列的宽高
-(CGSize)mainView:(TamMainView *)mainView sizeForCenterAtRow:(NSInteger)row col:(NSInteger)col;
//返回表格左侧宽高【设置isAutoSize = YES 就根据sizeForCenterAtRow返回,为NO时才有效】
-(CGSize)mainView:(TamMainView *)mainView sizeForLeftCellIndexPath:(NSIndexPath *)indexPath;
//返回表格顶部宽高【设置isAutoSize = YES 就根据sizeForCenterAtRow返回,为NO时才有效】
-(CGSize)mainView:(TamMainView *)mainView sizeForTopCellIndexPath:(NSIndexPath *)indexPath;

//返回表格每行每列的颜色
-(UIColor *)mainView:(TamMainView *)mainView colorForCenterAtRow:(NSInteger)row col:(NSInteger)col;
//返回表格左侧颜色【设置isAutoSize = YES 就根据colorForCenterAtRow返回,为NO时才有效】
-(UIColor *)mainView:(TamMainView *)mainView colorForLeftCellIndexPath:(NSIndexPath *)indexPath;
//返回表格头部颜色
-(UIColor *)mainView:(TamMainView *)mainView colorForTopCellIndexPath:(NSIndexPath *)indexPath;

//返回表格每行每列的视图
-(UIView *)mainView:(TamMainView *)mainView viewForCenterAtRow:(NSInteger)row col:(NSInteger)col;
//返回表格左侧的视图
-(UIView *)mainView:(TamMainView *)mainView viewForLeftCellIndexPath:(NSIndexPath *)indexPath;
//返回表格头部的视图
>>>>>>> origin/master
-(UIView *)mainView:(TamMainView *)mainView viewForTopCellIndexPath:(NSIndexPath *)indexPath;

@end

@interface TamMainView : UIView

@property(nonatomic,weak)id<TamMainViewDelegate> delegate;
@property(nonatomic,weak)id<TamMainViewDataSource> dataSource;
//是否根据内容cell的高宽自动适配头部与左侧的宽高【默认YES】
@property(nonatomic,assign)BOOL isAutoSize;
//是否能点击左上角【默认YES】
@property(nonatomic,assign)BOOL isCanTapLeftTop;
//是否根据内容cell的颜色自动适配左侧的颜色【默认YES】
@property(nonatomic,assign)BOOL isAutoColor;//只控制左边的颜色
//表格左上角属性
@property(nonatomic,copy)NSString *leftTopTitle;
@property(nonatomic,strong)UIFont *leftTopFont;
@property(nonatomic,strong)UIColor *leftTopBackgroundColor;
@property(nonatomic,strong)UIColor *leftTopTitleColor;
@property(nonatomic,assign)NSTextAlignment leftTopTextAlignment;

-(void)reloadView;

@end
