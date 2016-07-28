//
//  SearchTableViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "SearchTableViewCell.h"

@interface SearchTableViewCell()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_tags;
    UIView *_line;
}

@end
@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 80)];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width + 10, 5, 200, 30)];
        [self addSubview:_titleLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(5, _imageView.frame.origin.y + _imageView.frame.size.height + 4, self.frame.size.width, 1)];
        _line.backgroundColor = [UIColor grayColor];
        
        [self addSubview:_line];
        
        _tags = [[UILabel alloc] init];
        _tags.numberOfLines = 2;
        _tags.textColor = [UIColor grayColor];
        _tags.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_tags];
    }
    return self;
}
-(void)layoutSubviews
{
    _line.frame = CGRectMake(5, _imageView.frame.origin.y + _imageView.frame.size.height + 5, self.frame.size.width - 10, 1);
//    CGFloat *x = _imageView.frame.origin.x + _imageView.frame.size.width + 5;
    _tags.frame = CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width + 10, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 5, self.frame.size.width - 15 - _imageView.frame.size.width, 40);
    
}
-(void)setSearch:(MovieSearch *)search
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:search.poster]];
    [_tags setText:search.tags];
    [_titleLabel setText:search.title];
}

+(instancetype)createTableViewCellFromTabelView:(UITableView *)tableView
{
    static NSString *identify = @"searchCell";
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

@end
