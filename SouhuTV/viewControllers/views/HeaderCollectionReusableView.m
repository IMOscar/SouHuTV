//
//  HeaderCollectionReusableView.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        aView.backgroundColor = [UIColor whiteColor];
        
        _classifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 40)];
        _classifyTitleLabel.text = @"最新电影";
        _classifyTitleLabel.font = [UIFont systemFontOfSize:18];
        [aView addSubview:_classifyTitleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 185, 5, 180, 30)];
        detailLabel.text = @"更多>";
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont systemFontOfSize:15];
        detailLabel.textAlignment = 2;
        [aView addSubview:detailLabel];
        
        [self addSubview:aView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [aView addGestureRecognizer:tap];
    }
    return self;
}

-(void)tapAction:(id)sender
{
    self.tapedBlock(self.section);
}

-(void)setClassifyTitle:(NSString *)classifyTitle
{
    [_classifyTitleLabel setText:classifyTitle];
}

@end
