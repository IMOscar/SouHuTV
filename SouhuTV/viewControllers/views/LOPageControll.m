//
//  LOPageControll.m
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "LOPageControll.h"
#define PointWith 10
#define PointSpace 5

@implementation LOPageControll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame andTintColor:(UIColor *)tintColor andSelectedTintColor:(UIColor *)selectedTintColor
{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20);
    self = [super initWithFrame:newFrame];
    if (self) {
        _tintColor = tintColor;
        _selectedTintColor = selectedTintColor;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setNumberOfPages:(NSUInteger)numberOfPages
{
    if (_numberOfPages != numberOfPages) {
        for (int i = 1; i <= _numberOfPages; i++) {
            [(UIView *)[self viewWithTag:i] removeFromSuperview];
        }
    
        _numberOfPages = numberOfPages;
        
        for (int i = 0 ; i < numberOfPages; i ++ ) {
            UIView *aView = [[UIView alloc] init];

            if(i < numberOfPages / 2){
                aView.frame = CGRectMake(self.frame.size.width / 2 - (PointWith + PointSpace) * (numberOfPages/ 2 - i), 5, PointWith, PointWith);
            }else
            {
                aView.frame = CGRectMake(self.frame.size.width / 2 + (PointWith + PointSpace) * (i - numberOfPages/ 2), 5, PointWith, PointWith);
            }
            
            aView.tag = i + 1000;
            aView.layer.cornerRadius = 5;
            aView.layer.masksToBounds = YES;
            [aView setBackgroundColor:_tintColor];
            [self addSubview:aView];
        }
    }
}

-(void)setCurrentPage:(NSUInteger)currentPage
{
    if (_currentPage != currentPage) {
        UIView *aView = (UIView *)[self viewWithTag:_currentPage + 1000];
        [aView setBackgroundColor:_tintColor];
    }
    _currentPage = currentPage;
    UIView *v = (UIView *)[self viewWithTag:_currentPage + 1000];
    [v setBackgroundColor:_selectedTintColor];
    
}

-(void)setSelectedTintColor:(UIColor *)selectedTintColor
{
    if (_selectedTintColor != selectedTintColor) {
        [_selectedTintColor release];
        _selectedTintColor = [selectedTintColor retain];
        UIView *v = (UIView *)[self viewWithTag:_currentPage + 1000];
        [v setBackgroundColor:_selectedTintColor];
    }
}

-(void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        [_tintColor release];
        _tintColor = [tintColor retain];
        for (int i = 1; i <= self.subviews.count; i++) {
            UIView *v = (UIView *)[self viewWithTag:i + 1000];
            if (i == _currentPage + 1) {
                v.backgroundColor = _selectedTintColor;
            }else
            {
                v.backgroundColor = _tintColor;
            }
        }
    }
}
@end
