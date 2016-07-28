
//
//  LOCarouselFigureView.m
//  VideoTest
//
//  Created by 肖野 on 15/6/9.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "LOCarouselFigureView.h"
#import "XYMainFunction.h"
@implementation LOCarouselFigureView
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
        _imagesArray = [[NSArray alloc] init];

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
    }
    return self;
}

-(LOPageControll *)loPageControll
{
    if (_loPageControll == nil) {
        _loPageControll = [[LOPageControll alloc] initWithFrame:CGRectMake(self.bounds.size.width - 120, self.bounds.size.height - 20, 120, 20) andTintColor:[UIColor whiteColor] andSelectedTintColor:[UIColor yellowColor]];
    }
    return _loPageControll;
}

-(void)setImagesArray:(NSArray *)imagesArray
{
    
    if (_imagesArray != imagesArray) {
        
        _imagesArray = imagesArray;
        
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * (_imagesArray.count + 1), 0);
        
        //最后一张图片，放在第一张之前，达到缓冲效果
        MovieBaseInfo *baseInfoLast = (MovieBaseInfo *)[_imagesArray lastObject];
        
        UIImageView *image =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [image sd_setImageWithURL:[NSURL URLWithString:baseInfoLast.img]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [image addGestureRecognizer:tap];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        label.backgroundColor = [UIColor colorWithRed:0.953 green:0.937 blue:0.949 alpha:1];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor =[UIColor grayColor];
        label.text = [NSString stringWithFormat:@"  %@",baseInfoLast.title];
        [image addSubview:label];
        
        [_scrollView addSubview:image];
        
        
        for (int i = 0 ; i < _imagesArray.count; i++) {
            MovieBaseInfo *baseInfo = (MovieBaseInfo *)_imagesArray[i];
            _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
            
            UIImageView * aImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * (i + 1), 0, self.bounds.size.width, self.bounds.size.height)];
            aImage.backgroundColor = [UIColor greenColor];
            aImage.userInteractionEnabled = YES;
            [aImage sd_setImageWithURL:[NSURL URLWithString:baseInfo.img]];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [aImage addGestureRecognizer:tap];

            UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
            [alabel setText:[NSString stringWithFormat:@"  %@",baseInfo.title]];
            alabel.backgroundColor = [UIColor colorWithRed:0.953 green:0.937 blue:0.949 alpha:0.7];
            alabel.textColor =[UIColor grayColor];
            alabel.font = [UIFont systemFontOfSize:12];

            
            [aImage addSubview:alabel];
            [_scrollView addSubview:aImage];
        }
        
        [self loPageControll].numberOfPages = _imagesArray.count;
        _loPageControll.currentPage = 0;
        
        [self addSubview:_loPageControll];
    }
    
    _random = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(randomImage:) userInfo:nil repeats:YES];
}

-(void)randomImage:(id)sender
{
    if (_loPageControll.currentPage < _imagesArray.count-1) {
        _loPageControll.currentPage ++;
        _scrollView.contentOffset = CGPointMake((_loPageControll.currentPage + 1) * self.bounds.size.width, 0);
    }else
    {
        _scrollView.contentOffset =CGPointMake(self.bounds.size.width, 0);
        _loPageControll.currentPage = 0;
    }
}
/**
 *  单击手势动作
 *
 *  @param scrollView
 */
-(void)tapAction:(id)sender
{
    [self.delegate tapImage:_loPageControll.currentPage];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    
    _loPageControll.currentPage = point.x / self.bounds.size.width - 1;

    if (point.x == 0) {
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width * _imagesArray.count, 0);
        _loPageControll.currentPage = _imagesArray.count - 1;
    }
    if (point.x == self.bounds.size.width * _imagesArray.count) {
        _scrollView.contentOffset = CGPointMake(0, 0);
    }
}

@end
