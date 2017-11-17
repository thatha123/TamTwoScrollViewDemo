//
//  ViewController.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "ViewController.h"
#import "TamMainView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TamMainView *mainView = [[TamMainView alloc]init];
    mainView.frame = self.view.bounds;
    [self.view addSubview:mainView];
}

@end
