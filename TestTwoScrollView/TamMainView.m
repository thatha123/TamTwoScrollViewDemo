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

static const CGFloat LeftTopViewW = 100;//左上角视图宽
static const CGFloat LeftTopViewH = 50;//左上角视图高

@interface TamMainView()<TamLeftViewDelegate,TamCenterViewDelegate,TamTopViewDelegate,TamLeftTopViewDelegate>

@property(nonatomic,strong)TamLeftView *leftView;
@property(nonatomic,strong)TamTopView *topView;
@property(nonatomic,strong)TamCenterView *centerView;

@end

@implementation TamMainView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    //左上角视图-----------------------------------
    TamLeftTopView *leftTopView = [[TamLeftTopView alloc]init];
    leftTopView.delegate = self;
    leftTopView.backgroundColor = [UIColor redColor];
    [self addSubview:leftTopView];
    //VFL约束
    leftTopView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *leftTopViews = NSDictionaryOfVariableBindings(leftTopView);
    NSDictionary *mertrics = @{@"LeftTopViewW":[NSString stringWithFormat:@"%f",LeftTopViewW],
                               @"LeftTopViewH":[NSString stringWithFormat:@"%f",LeftTopViewH]
                               }; // 参数\数值
    NSArray *layoutConst1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftTopView(LeftTopViewW)]" options:0 metrics:mertrics views:leftTopViews];
    NSArray *layoutConst2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[leftTopView(LeftTopViewH)]" options:0 metrics:mertrics views:leftTopViews];
    [self addConstraints:layoutConst1];
    [self addConstraints:layoutConst2];
    
    //左边视图-----------------------------------
    TamLeftView *leftView = [[TamLeftView alloc]init];
    self.leftView = leftView;
    leftView.delegate = self;
    leftView.backgroundColor = [UIColor blueColor];
    [self addSubview:leftView];
    //VFL约束
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *leftViews = NSDictionaryOfVariableBindings(leftView,leftTopView);
    NSArray *layoutConst3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftView(leftTopView)]" options:0 metrics:0 views:leftViews];
    NSArray *layoutConst4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftTopView]-0-[leftView]-0-|" options:0 metrics:0 views:leftViews];
    [self addConstraints:layoutConst3];
    [self addConstraints:layoutConst4];
    
    //顶部视图-----------------------------------
    TamTopView *topView = [[TamTopView alloc]init];
    self.topView = topView;
    topView.delegate = self;
    topView.backgroundColor = [UIColor greenColor];
    [self addSubview:topView];
    //VFL约束
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *topViews = NSDictionaryOfVariableBindings(topView,leftTopView);
    NSArray *layoutConst5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftTopView]-0-[topView]-0-|" options:0 metrics:0 views:topViews];
    NSArray *layoutConst6 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topView(leftTopView)]" options:0 metrics:0 views:topViews];
    [self addConstraints:layoutConst5];
    [self addConstraints:layoutConst6];
    
    //中间视图-----------------------------------
    TamCenterView *centerView = [[TamCenterView alloc]init];
    self.centerView = centerView;
    centerView.delegate = self;
    centerView.backgroundColor = [UIColor cyanColor];
    [self addSubview:centerView];
    //VFL约束
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *centerViews = NSDictionaryOfVariableBindings(centerView,topView,leftView);
    NSArray *layoutConst7 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftView]-0-[centerView]-0-|" options:0 metrics:0 views:centerViews];
    NSArray *layoutConst8 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-0-[centerView]-0-|" options:0 metrics:0 views:centerViews];
    [self addConstraints:layoutConst7];
    [self addConstraints:layoutConst8];
}

#pragma mark - TamLeftTopViewDelegate
-(void)clickTopOrBottomView:(int)type
{
    switch (type) {
        case 0:
        {
            [self.topView setPoint:CGPointMake(0, 0)];
        }
            break;
        case 1:
        {
            [self.leftView setPoint:CGPointMake(0, 0)];
        }
            break;
        default:
            break;
    }
}

#pragma mark - TamLeftViewDelegate
-(void)changeLeftScrollView:(UIScrollView *)leftScrollView
{
    NSLog(@"左边视图,%f",leftScrollView.contentOffset.y);
    [self.centerView setPointWithScrollView:leftScrollView type:0];
}

#pragma mark - TamTopViewDelegate
-(void)changeTopScrollView:(UIScrollView *)topScrollView
{
    NSLog(@"顶部视图,%f",topScrollView.contentOffset.x);
    [self.centerView setPointWithScrollView:topScrollView type:1];
}

#pragma mark - TamCenterViewDelegate
-(void)changeCenterScrollView:(UIScrollView *)centerScrollView
{
    NSLog(@"中间视图,%@",NSStringFromCGPoint(centerScrollView.contentOffset));
    [self.leftView setPointWithScrollView:centerScrollView];
    [self.topView setPointWithScrollView:centerScrollView];
}

@end
