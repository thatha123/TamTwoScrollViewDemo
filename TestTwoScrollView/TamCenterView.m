//
//  TamCenterView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamCenterView.h"

@interface TamCenterView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

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
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, scrollView.contentOffset.y);
    }else if (type == 1){//顶部
        self.scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.scrollView.contentOffset.y);
    }

}

-(void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(50*100, 50*100);
    [self addSubview:scrollView];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(scrollView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(scrollView)]];
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:50];
    label.textColor = [UIColor whiteColor];
    label.text = @"楼主最帅了";
    [scrollView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(changeCenterScrollView:)]) {
        [self.delegate changeCenterScrollView:scrollView];
    }
}

@end
