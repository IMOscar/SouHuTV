//
//  ListCollectionViewCell.m
//  
//
//  Created by 肖野 on 15/6/11.
//
//

#import "ListCollectionViewCell.h"

@interface ListCollectionViewCell()
{
    UIImageView *_imageView;
    UILabel * _textLabel;
}

@end

@implementation ListCollectionViewCell

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

-(void)setMovie:(MovieDetailInfo *)movie
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:movie.poster]];
    
    _textLabel.text = movie.title;
}

-(void)setBaseInfo:(MovieBaseInfo *)baseInfo
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:baseInfo.img]];
    
    _textLabel.text = baseInfo.title;
}
@end
