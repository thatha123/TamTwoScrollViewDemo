//
//  TamMainView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamMainView.h"
#import "TamLeftView.h"
#import "TamTopView.h"
#import "TamLeftTopView.h"
#import "TamCenterView.h"

static const CGFloat TamDefW = 100;//默认宽
static const CGFloat TamDefH = 40;//默认高

@interface TamMainView()<TamLeftViewDelegate,TamCenterViewDelegate,TamTopViewDelegate,TamLeftTopViewDelegate>

@property(nonatomic,weak)TamLeftView *leftView;
@property(nonatomic,weak)TamTopView *topView;
@property(nonatomic,weak)TamCenterView *centerView;

@property(nonatomic,weak)TamLeftTopView *leftTopView;

@end

@implementation TamMainView

-(void)reloadView
{
    //更新宽度 高度
    [self setUIFrame];
    //刷新数据
    [self.leftView.tableView reloadData];
    [self.topView.collectionView reloadData];
    [self.centerView.tableView reloadData];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setUIFrame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupData];
    }
    return self;
}

-(void)setupData
{
    //初始化数据
    self.isAutoSize = YES;
    self.isCanTapLeftTop = YES;
    self.isAutoColor = YES;
    //初始化控件
    [self setupUI];
}

-(void)setUIFrame
{
    CGFloat width = TamDefW;
    CGFloat height = TamDefH;
    if ([self.delegate respondsToSelector:@selector(widthForLeftCellWithMainView:)]) {
        width = [self.delegate widthForLeftCellWithMainView:self];
    }
    if ([self.delegate respondsToSelector:@selector(heightForTopCellWithMainView:)]) {
        height = [self.delegate heightForTopCellWithMainView:self];
    }
    self.leftTopView.frame = CGRectMake(0, 0, width, height);
    self.leftView.frame = CGRectMake(0, height, width, self.frame.size.height-height);
    self.topView.frame = CGRectMake(width, 0, self.frame.size.width-width, height);
    self.centerView.frame = CGRectMake(width, height, self.frame.size.width-width, self.frame.size.height-height);
}

-(void)setupUI
{
    //左上角视图-----------------------------------
    TamLeftTopView *leftTopView = [[TamLeftTopView alloc]init];
    self.leftTopView = leftTopView;
    leftTopView.delegate = self;
    leftTopView.backgroundColor = [UIColor clearColor];
    [self addSubview:leftTopView];

    //左边视图-----------------------------------
    TamLeftView *leftView = [[TamLeftView alloc]init];
    self.leftView = leftView;
    leftView.delegate = self;
    leftView.backgroundColor = [UIColor clearColor];
    [self addSubview:leftView];

    //顶部视图-----------------------------------
    TamTopView *topView = [[TamTopView alloc]init];
    self.topView = topView;
    topView.delegate = self;
    topView.backgroundColor = [UIColor clearColor];
    [self addSubview:topView];

    //中间视图-----------------------------------
    TamCenterView *centerView = [[TamCenterView alloc]init];
    self.centerView = centerView;
    centerView.delegate = self;
    centerView.backgroundColor = [UIColor clearColor];
    [self addSubview:centerView];

    //数据赋值
    //左上角---------
    //能否点击返回顶部
    leftTopView.isCanTapLeftTop = self.isCanTapLeftTop;
    //左边---------
    //几行
    leftView.leftCellNum = ^NSInteger(NSInteger section) {
        return [self.dataSource mainView:self numberOfRowsInSection:section];
    };
    //标题
    leftView.leftCellTitle = ^NSString *(NSIndexPath *indexPath) {
        return [self.dataSource mainView:self cellForLeftTitleAtIndexPath:indexPath];
    };
    //cell的大小
    leftView.leftCellSize = ^CGSize(NSIndexPath *indexPath) {
        CGFloat width = TamDefW;
        CGFloat height = TamDefH;
        if ([self.delegate respondsToSelector:@selector(widthForLeftCellWithMainView:)]) {
            width = [self.delegate widthForLeftCellWithMainView:self];
        }
        if ([self.delegate respondsToSelector:@selector(heightForTopCellWithMainView:)]) {
            height = [self.delegate heightForTopCellWithMainView:self];
        }
        if (self.isAutoSize) {
            if ([self.delegate respondsToSelector:@selector(mainView:heightForCenterAtRow:)]) {
                height = [self.delegate mainView:self heightForCenterAtRow:indexPath.row];
            }
            return CGSizeMake(width, height);
        }
        
        if ([self.delegate respondsToSelector:@selector(mainView:heightForLeftCellIndexPath:)]) {
            height = [self.delegate mainView:self heightForLeftCellIndexPath:indexPath];
        }
        return CGSizeMake(width, height);
    };
    //cell的颜色
    leftView.leftCellColor = ^UIColor *(NSIndexPath *indexPath) {
        if (self.isAutoColor) {
            if ([self.delegate respondsToSelector:@selector(mainView:colorForCenterAtRow:col:)]) {
                return [self.delegate mainView:self colorForCenterAtRow:indexPath.row col:0];
            }
        }
        if ([self.delegate respondsToSelector:@selector(mainView:colorForLeftCellIndexPath:)]) {
            return [self.delegate mainView:self colorForLeftCellIndexPath:indexPath];
        }
        return nil;
    };
    //添加视图
    leftView.leftCellView = ^UIView *(NSIndexPath *indexPath) {
        if ([self.delegate respondsToSelector:@selector(mainView:viewForLeftCellIndexPath:)]) {
            return [self.delegate mainView:self viewForLeftCellIndexPath:indexPath];
        }
        return nil;
    };
    //头部---------
    //几列
    topView.topCellNum = ^NSInteger(NSInteger section) {
        return [self.dataSource mainView:self numberOfColsInSection:section];
    };
    //标题
    topView.topCellTitle = ^NSString *(NSIndexPath *indexPath) {
        return [self.dataSource mainView:self cellForTopTitleAtIndexPath:indexPath];
    };
    //cell大小
    topView.topCellSize = ^CGSize(NSIndexPath *indexPath) {
        CGFloat width = TamDefW;
        CGFloat height = TamDefH;
        if ([self.delegate respondsToSelector:@selector(widthForLeftCellWithMainView:)]) {
            width = [self.delegate widthForLeftCellWithMainView:self];
        }
        if ([self.delegate respondsToSelector:@selector(heightForTopCellWithMainView:)]) {
            height = [self.delegate heightForTopCellWithMainView:self];
        }
        if (self.isAutoSize) {
            if ([self.delegate respondsToSelector:@selector(mainView:widthForCenterAtCol:)]) {
                width = [self.delegate mainView:self widthForCenterAtCol:indexPath.row];
            }
            return CGSizeMake(width, height);
        }
        if ([self.delegate respondsToSelector:@selector(mainView:widthForTopCellIndexPath:)]) {
            width = [self.delegate mainView:self widthForTopCellIndexPath:indexPath];
        }
        return CGSizeMake(width, height);
    };
    //cell的颜色
    topView.topCellColor = ^UIColor *(NSIndexPath *indexPath) {
        if ([self.delegate respondsToSelector:@selector(mainView:colorForTopCellIndexPath:)]) {
            return [self.delegate mainView:self colorForTopCellIndexPath:indexPath];
        }
        if ([self.dataSource mainView:self numberOfColsInSection:0] > 1 || [self.dataSource mainView:self numberOfRowsInSection:0] > 1) {
            if ([self.delegate respondsToSelector:@selector(mainView:colorForCenterAtRow:col:)]) {
                return [self.delegate mainView:self colorForCenterAtRow:1 col:1];
            }
        }
        return nil;
    };
    //添加视图
    topView.topCellView = ^UIView *(NSIndexPath *indexPath) {
        if ([self.delegate respondsToSelector:@selector(mainView:viewForTopCellIndexPath:)]) {
            return [self.delegate mainView:self viewForTopCellIndexPath:indexPath];
        }
        return nil;
    };
    //中间---------
    //几行
    centerView.centerCellRow = ^NSInteger(NSInteger section) {
        return [self.dataSource mainView:self numberOfRowsInSection:section];
    };
    //几列
    centerView.centerCellCollRow = ^NSInteger(NSInteger section) {
        return [self.dataSource mainView:self numberOfColsInSection:section];
    };
    //内容
    centerView.centerCellTitle = ^NSString *(NSInteger row, NSInteger col) {
        return [self.dataSource mainView:self cellForCenterTitleAtRow:row col:col];
    };
    //cell大小
    centerView.centerCellSize = ^CGSize(NSInteger row, NSInteger col) {
        CGFloat width = TamDefW;
        CGFloat height = TamDefH;
        if ([self.delegate respondsToSelector:@selector(widthForLeftCellWithMainView:)]) {
            width = [self.delegate widthForLeftCellWithMainView:self];
        }
        if ([self.delegate respondsToSelector:@selector(heightForTopCellWithMainView:)]) {
            height = [self.delegate heightForTopCellWithMainView:self];
        }
        if ([self.delegate respondsToSelector:@selector(mainView:widthForCenterAtCol:)]) {
            width = [self.delegate mainView:self widthForCenterAtCol:col];
        }
        if ([self.delegate respondsToSelector:@selector(mainView:heightForCenterAtRow:)]) {
            height = [self.delegate mainView:self heightForCenterAtRow:row];
        }
        return CGSizeMake(width, height);
    };
    //cell颜色
    centerView.centerCellColor = ^UIColor *(NSInteger row, NSInteger col) {
        if ([self.delegate respondsToSelector:@selector(mainView:colorForCenterAtRow:col:)]) {
            return [self.delegate mainView:self colorForCenterAtRow:row col:col];
        }
        return nil;
    };
    //添加视图
    centerView.centerCellView = ^UIView *(NSInteger row, NSInteger col) {
        if ([self.delegate respondsToSelector:@selector(mainView:viewForCenterAtRow:col:)]) {
            return [self.delegate mainView:self viewForCenterAtRow:row col:col];
        }
        return nil;
    };
}

-(void)setLeftTopFont:(UIFont *)leftTopFont
{
    _leftTopFont = leftTopFont;
    self.leftTopView.topLabel.font = _leftTopFont;
}

-(void)setLeftTopTitle:(NSString *)leftTopTitle
{
    _leftTopTitle = leftTopTitle;
    self.leftTopView.topLabel.text = _leftTopTitle;
}

-(void)setLeftTopBackgroundColor:(UIColor *)leftTopBackgroundColor
{
    _leftTopBackgroundColor = leftTopBackgroundColor;
    self.leftTopView.backgroundColor = _leftTopBackgroundColor;
}

-(void)setLeftTopTitleColor:(UIColor *)leftTopTitleColor
{
    _leftTopTitleColor = leftTopTitleColor;
    self.leftTopView.topLabel.textColor = _leftTopTitleColor;
}

-(void)setLeftTopTextAlignment:(NSTextAlignment)leftTopTextAlignment
{
    _leftTopTextAlignment = leftTopTextAlignment;
    self.leftTopView.topLabel.textAlignment = _leftTopTextAlignment;
}

#pragma mark - TamLeftTopViewDelegate
-(void)clickLeftTopView
{
    [self stopScrollView:self.topView.collectionView];
    for (TamCenterTableViewCell *cell in self.centerView.tableView.visibleCells) {
        [self stopScrollView:cell.collectionView point:CGPointMake(0, 0)];
    }
    [self stopScrollView:self.leftView.tableView];
    [self stopScrollView:self.centerView.tableView point:CGPointMake(0, 0)];
}

-(void)stopScrollView:(UIScrollView *)scrollView
{
    [self stopScrollView:scrollView point:CGPointMake(0, 0)];
}

-(void)stopScrollView:(UIScrollView *)scrollView point:(CGPoint)point
{
    CGPoint offset = scrollView.contentOffset;
    (scrollView.contentOffset.y > 0) ? offset.y-- : offset.y++;
    [scrollView setContentOffset:point animated:NO];
}

#pragma mark - TamLeftViewDelegate
-(void)changeLeftScrollView:(UIScrollView *)leftScrollView
{
    [self.centerView setPointWithScrollView:leftScrollView type:0];
}

#pragma mark - TamTopViewDelegate
-(void)changeTopScrollView:(UIScrollView *)topScrollView
{
    [self.centerView setPointWithScrollView:topScrollView type:1];
}

#pragma mark - TamCenterViewDelegate
-(void)changeCenterYScrollView:(UIScrollView *)centerScrollView
{
    self.leftView.tableView.contentOffset = CGPointMake(0, centerScrollView.contentOffset.y);
}

-(void)changeCenterXScrollView:(UIScrollView *)centerScrollView
{
    self.topView.collectionView.contentOffset = CGPointMake(centerScrollView.contentOffset.x, 0);
}

@end
