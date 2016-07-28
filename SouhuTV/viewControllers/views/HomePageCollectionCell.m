//
//  HomePageCollectionCell.m
//  VideoText
//
//  Created by 何欣 on 15/6/9.
//  Copyright (c) 2015年 何欣. All rights reserved.
//

#import "HomePageCollectionCell.h"
#import "XYMainFunction.h"
@interface HomePageCollectionCell  ()
{
    UIImageView *_imageView;
    UILabel * _textLabel;
}
@end



@implementation HomePageCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 25)];
        [self addSubview:_imageView];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 25, frame.size.width, 25)];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor =[UIColor grayColor];
        [self addSubview:_textLabel];
    }
    return self;
}


-(void)setBaseInfo:(MovieBaseInfo *)baseInfo{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:baseInfo.img]];
    
    _textLabel.text = baseInfo.title;
    
}


@end
