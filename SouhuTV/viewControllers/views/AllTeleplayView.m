//
//  AllTeleplayView.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "AllTeleplayView.h"

@implementation AllTeleplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 40, 20)];
        label.font = [UIFont systemFontOfSize:17];
        label.text = @"剧集";
        label.textColor = [UIColor blackColor];
        [_scrollView addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, label.frame.origin.y + label.frame.size.height + 10, self.frame.size.width - 10, 1)];
        line.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:line];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 20, 10, 25, 25)];
        [btn setBackgroundImage:[UIImage imageNamed:@"Btn-ClearInput-Normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Btn-ClearInput-Highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    return self;
}

-(void)deleteAction:(id)sender
{
    [self removeFromSuperview];
}

-(void)setArray:(NSArray *)array
{
    _array = array;
    NSUInteger j = array.count / 5;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, j * 60);
    
    int cun = 0;
    
    for (int i = 0; i < j; i ++) {
        for (int k = 0; k < 5; k ++) {
            cun ++;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(5 + 72 * k, 50 + 35 * i, 67, 30);
            btn.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.953 alpha:1];
            [btn setTitle:[NSString stringWithFormat:@"%d", cun] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.263 green:0.275 blue:0.282 alpha:1] forState:UIControlStateNormal];
            btn.tag = 100 + cun;
            [btn addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:btn];
        }
    }
}

-(void)tapButtonAction:(UIButton *)sender
{
    NSLog(@"%ld", sender.tag - 100);
    self.selecblock(sender.tag - 100);
}
@end
