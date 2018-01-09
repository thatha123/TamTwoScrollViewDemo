//
//  TamLeftView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamLeftView.h"

#pragma mark - TamLeftView
@interface TamLeftView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TamLeftView

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
    if ([self.delegate respondsToSelector:@selector(changeLeftScrollView:)]) {
        [self.delegate changeLeftScrollView:scrollView];
    }
}

-(void)setupUI
{
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
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
    return self.leftCellNum ? self.leftCellNum(section) : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"leftCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (id sub in cell.contentView.subviews) {
        [sub removeFromSuperview];
    }
    UIView *view = self.leftCellView(indexPath);
    if (view) {
        cell.textLabel.text = @"";
        [cell.contentView addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(view)]];
    }else{
        cell.textLabel.text = self.leftCellTitle(indexPath);
    }
    cell.contentView.backgroundColor = self.leftCellColor(indexPath);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.leftCellSize(indexPath).height;
}

@end
