//
//  LibrarySecondCollectionViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "LibrarySecondCollectionViewCell.h"

@interface LibrarySecondCollectionViewCell ()
{
    UILabel *_topicLabel;
}
@end

@implementation LibrarySecondCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 3, self.frame.size.width - 4, self.frame.size.height - 6)];
        _topicLabel.textAlignment = 1;
        _topicLabel.textColor = [UIColor grayColor];
        _topicLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_topicLabel];
    }
    return self;
}

//-(void)setTopicInfo:(MovieClassifyInfo *)topicInfo
//{
//    _topicLabel.text = topicInfo.mTitle;
//}
-(void)setMTitle:(NSString *)mTitle
{
    _topicLabel.text = mTitle;
}

@end
