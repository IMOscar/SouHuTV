//
//  LibraryCollectionViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "LibraryCollectionViewCell.h"
#import "XYMainFunction.h"

#define ImageWidth 43

@interface LibraryCollectionViewCell ()
{
    UIImageView *_imageView;
    UILabel *_textLabel;
}
@end

@implementation LibraryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0.882 green:0.882 blue:0.902 alpha:1];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - ImageWidth)/2, 10, ImageWidth,  ImageWidth)];
        
        _imageView.layer.cornerRadius = ImageWidth / 2;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.frame.origin.y + ImageWidth + 5, frame.size.width, 25)];
        _textLabel.textAlignment = 1;
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor =[UIColor blackColor];
        [self addSubview:_textLabel];
    }
    return self;
}

-(void)setClassifyInfo:(MovieClassifyInfo *)classifyInfo
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:classifyInfo.icon_url]];
    
    _textLabel.text = classifyInfo.mTitle;
}

@end
