//
//  HomePageCollectionReusableView.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "HomePageCollectionReusableView.h"

@implementation HomePageCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imagesArray = [[NSArray alloc] init];
    }
    return self;
}

-(void)setImagesArray:(NSArray *)imagesArray
{
    LOCarouselFigureView *carous = [[LOCarouselFigureView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height - 40)];
    //carous单击手势代理事件
    carous.delegate = self;
    carous.imagesArray = [[NSArray alloc] initWithArray:imagesArray];
    [self addSubview:carous];
    
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, carous.frame.size.height, self.frame.size.width, 40)];
    aView.backgroundColor = [UIColor whiteColor];
    
    _classifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 40)];
    _classifyTitleLabel.font = [UIFont systemFontOfSize:18];
    [aView addSubview:_classifyTitleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 185, 5, 180, 30)];
    detailLabel.text = @"更多>";
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.textAlignment = 2;
    [aView addSubview:detailLabel];
    [self addSubview:aView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [aView addGestureRecognizer:tap];
    
}

-(void)tapAction:(id)sender
{
    self.tapedBlock(self.section);
}

-(void)setClassifyTitle:(NSString *)classifyTitle
{
    [_classifyTitleLabel setText:classifyTitle];
}

-(void)tapImage:(NSUInteger)index
{
    self.selectedBlock(index);
}
@end
