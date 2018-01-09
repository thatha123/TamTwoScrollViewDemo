//
//  ViewController.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "ViewController.h"
#import "TamMainView.h"

@interface ViewController ()<TamMainViewDelegate,TamMainViewDataSource>

@property(nonatomic,assign)BOOL isChange;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TamMainView *mainView = [[TamMainView alloc]init];
    mainView.leftTopTitle = @"主题";
    mainView.leftTopBackgroundColor = [[UIColor cyanColor]colorWithAlphaComponent:0.5];
    mainView.frame = self.view.bounds;
    mainView.delegate = self;
    mainView.dataSource = self;
    [self.view addSubview:mainView];
}

#pragma mark - TamMainViewDataSource
-(NSInteger)mainView:(TamMainView *)mainView numberOfColsInSection:(NSInteger)section
{
    return 50;
}

-(NSInteger)mainView:(TamMainView *)mainView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(NSString *)mainView:(TamMainView *)mainView cellForTopTitleAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"头部:%zd",indexPath.row];
}

-(NSString *)mainView:(TamMainView *)mainView cellForLeftTitleAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"左边:%zd",indexPath.row];
}

-(NSString *)mainView:(TamMainView *)mainView cellForCenterTitleAtRow:(NSInteger)row col:(NSInteger)col
{
    return [NSString stringWithFormat:@"行:%zd-列:%zd",row,col];
}

#pragma mark - TamMainViewDelegate
-(CGFloat)mainView:(TamMainView *)mainView heightForCenterAtRow:(NSInteger)row
{
    if (row == 2) {//第2行返回高度
        return 100;
    }
    return 40;
}

-(CGFloat)mainView:(TamMainView *)mainView widthForCenterAtCol:(NSInteger)col
{
    if (col == 0) {//第0列返回宽度
        return 150;
    }
    return 100;
}

-(UIColor *)mainView:(TamMainView *)mainView colorForCenterAtRow:(NSInteger)row col:(NSInteger)col
{
    return row%2 == 0 ? [[UIColor lightGrayColor]colorWithAlphaComponent:0.5] : [[UIColor cyanColor]colorWithAlphaComponent:0.5];
}

-(UIView *)mainView:(TamMainView *)mainView viewForCenterAtRow:(NSInteger)row col:(NSInteger)col
{
    if (row%2 != 0) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"点击" forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.5];
        btn.tag = [[NSString stringWithFormat:@"%zd%zd",row,col] integerValue];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        return btn;
    }
    return nil;
}

-(void)btnAction:(UIButton *)sender
{
    NSLog(@"点击:%zd",sender.tag);
}

@end
