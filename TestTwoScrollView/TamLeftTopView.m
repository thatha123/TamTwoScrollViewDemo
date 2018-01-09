//
//  TamLeftTopView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamLeftTopView.h"

@interface TamLeftTopView()

@property(nonatomic,strong)UITapGestureRecognizer *tapGes;

@end

@implementation TamLeftTopView

-(UILabel *)topLabel
{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_topLabel];
    }
    return _topLabel;
}

-(void)clickTopView
{
    if ([self.delegate respondsToSelector:@selector(clickLeftTopView)]) {
        [self.delegate clickLeftTopView];
    }
}

-(UITapGestureRecognizer *)tapGes
{
    if (!_tapGes) {
        _tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopView)];
        _tapGes.numberOfTapsRequired = 1;
    }
    return _tapGes;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.userInteractionEnabled = YES;
    if (self.isCanTapLeftTop) {
        [self addGestureRecognizer:self.tapGes];
    }else{
        [self removeGestureRecognizer:_tapGes];
    }
    _topLabel.frame = self.frame;
}

@end
