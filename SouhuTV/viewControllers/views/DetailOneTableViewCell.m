//
//  DetailOneTableViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "DetailOneTableViewCell.h"

@interface DetailOneTableViewCell()
{
    UILabel *_titleLabel;
    UILabel *_score;
}

@end

@implementation DetailOneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _score = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, self.frame.size.width, 20)];
        _score.font = [UIFont systemFontOfSize:12];
        _score.textColor = [UIColor grayColor];
        [self.contentView addSubview:_score];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_titleLabel];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 5, 40, 40)];
        //    [btn setBackgroundColor:[UIColor greenColor]];
        //    [btn setTitle:@"缓存" forState:UIControlStateNormal];
        //    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Upload-Btn-Download-Normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Upload-Btn-Download-Highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(cacheAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}

-(void)layoutSubviews
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, self.frame.size.height - 1, self.frame.size.width - 10, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line];
}

+(instancetype)createTableViewCellByTableView:(UITableView *)tableView
{
    static NSString *str = @"cell";
    DetailOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[DetailOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    return cell;
}

-(void)setMovie:(MovieDetailInfo *)movie
{
    _movie = movie;
    
    _score.text =[NSString stringWithFormat:@"评分%@",movie.rating];
  
    _titleLabel.text = movie.title;
}

//缓存按钮
-(void)cacheAction:(id)sender
{
    self.downloadBlock(self.movie);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
