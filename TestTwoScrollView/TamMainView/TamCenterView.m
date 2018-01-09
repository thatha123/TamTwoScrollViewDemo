//
//  TamCenterView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamCenterView.h"

@interface TamCenterView()<UITableViewDelegate,UITableViewDataSource>
{
    CGPoint _cellContentOffset;
}

@end

@implementation TamCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setPointWithScrollView:(UIScrollView *)scrollView type:(int)type
{
    if (type == 0) {//左边
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, scrollView.contentOffset.y);
    }else if (type == 1){//顶部
        for (TamCenterTableViewCell *cell in self.tableView.visibleCells) {
            cell.collectionView.contentOffset = scrollView.contentOffset;
        }
        _cellContentOffset = scrollView.contentOffset;
    }

}

-(void)setupUI
{
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    [self addSubview:tableView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.centerCellRow ? self.centerCellRow(section) : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TamCenterTableViewCell *cell = [TamCenterTableViewCell centerTableViewCellWithTableView:tableView];
    cell.contentViewCellDidScrollBlock = ^(UIScrollView *scrollView) {
        if ([self.delegate respondsToSelector:@selector(changeCenterXScrollView:)]) {
            [self.delegate changeCenterXScrollView:scrollView];
        }
    };
    cell.centerCellCollRow = ^NSInteger(NSInteger section) {
        return self.centerCellCollRow ? self.centerCellCollRow(section) : 0;
    };
    cell.centerCollCellTitle = ^NSString *(NSInteger col) {
        return self.centerCellTitle(indexPath.row,col);
    };
    cell.centerCollCellSize = ^CGSize(NSInteger col) {
        return self.centerCellSize(indexPath.row,col);
    };
    cell.centerCollCellColor = ^UIColor *(NSInteger col) {
        return self.centerCellColor(indexPath.row,col);
    };
    cell.centerCollCellView = ^UIView *(NSInteger col) {
        return self.centerCellView(indexPath.row,col);
    };
    cell.collectionView.contentOffset = _cellContentOffset;
    [cell.collectionView reloadData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.centerCellSize(indexPath.row,0).height;//没行的高度必相同 所以取0列
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(changeCenterYScrollView:)]) {
        [self.delegate changeCenterYScrollView:scrollView];
    }
}

@end

@interface TamCenterTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation TamCenterTableViewCell

static NSString *collCellId = @"centerCollCell";

+(instancetype)centerTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"centerCell";
    TamCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[TamCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

/**
 *  初始化UI
 */
-(void)setupUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[TamCenterCollectionViewCell class] forCellWithReuseIdentifier:collCellId];
    [self.contentView addSubview:collectionView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.centerCellCollRow ? self.centerCellCollRow(section) : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TamCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collCellId forIndexPath:indexPath];
    for (id sub in cell.contentView.subviews) {
        if ([sub tag] != 5555) {
            [sub removeFromSuperview];
        }
    }
    UIView *view = self.centerCollCellView(indexPath.item);
    if (view) {
        cell.label.text = @"";
        [cell.contentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
    }else{
        cell.label.text = self.centerCollCellTitle(indexPath.item);
    }
    cell.contentView.backgroundColor = self.centerCollCellColor(indexPath.item);
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.contentViewCellDidScrollBlock) {
        self.contentViewCellDidScrollBlock(scrollView);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.centerCollCellSize(indexPath.item);
}

@end

@implementation TamCenterCollectionViewCell

-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.tag = 5555;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_label]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_label)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_label]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_label)]];
    }
    return _label;
}


@end
