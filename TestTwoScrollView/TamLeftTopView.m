//
//  TamLeftTopView.m
//  TestTwoScrollView
//
//  Created by xin chen on 2017/11/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamLeftTopView.h"

@interface TamLeftTopView()

@property(nonatomic,strong)UILabel *topLabel;
@property(nonatomic,strong)UILabel *bottomLabel;

@end

@implementation TamLeftTopView

-(UILabel *)topLabel
{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.transform = CGAffineTransformMakeRotation(M_PI_4/2);
        _topLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopLabel)];
        tapGes.numberOfTapsRequired = 1;
        [_topLabel addGestureRecognizer:tapGes];
        [self addSubview:_topLabel];
    }
    return _topLabel;
}

-(void)clickTopLabel
{
    if ([self.delegate respondsToSelector:@selector(clickTopOrBottomView:)]) {
        [self.delegate clickTopOrBottomView:0];
    }
}

-(UILabel *)bottomLabel
{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.transform = CGAffineTransformMakeRotation(M_PI_4/2);
        _bottomLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBottomLabel)];
        tapGes.numberOfTapsRequired = 1;
        [_bottomLabel addGestureRecognizer:tapGes];
        [self addSubview:_bottomLabel];
    }
    return _bottomLabel;
}

-(void)clickBottomLabel
{
    if ([self.delegate respondsToSelector:@selector(clickTopOrBottomView:)]) {
        [self.delegate clickTopOrBottomView:1];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.topLabel.text = @"头部";
    self.topLabel.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height/2);
    
    self.bottomLabel.text = @"左部";
    self.bottomLabel.frame = CGRectMake(-10, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:1];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [[UIColor blackColor] setFill];
    [path fill];
    [path stroke];
}

@end
