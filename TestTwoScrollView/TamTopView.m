//
//  TamTopView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamTopView.h"

@interface TamTopView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation TamTopView

static NSString *cellId = @"TamTopCollectionCell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(changeTopScrollView:)]) {
        [self.delegate changeTopScrollView:scrollView];
    }
}

-(void)setupUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[TamTopCollectionCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:collectionView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topCellNum ? self.topCellNum(section) : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TamTopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    for (id sub in cell.contentView.subviews) {
        if ([sub tag] != 5555) {
            [sub removeFromSuperview];
        }
    }
    UIView *view = self.topCellView(indexPath);
    if (view) {
        cell.label.text = @"";
        [cell.contentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
    }else{
        cell.label.text = self.topCellTitle(indexPath);
    }
    cell.contentView.backgroundColor = self.topCellColor(indexPath);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topCellSize(indexPath);
}

@end

@implementation TamTopCollectionCell

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
