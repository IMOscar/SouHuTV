//
//  DetailTwoTableViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "DetailTwoTableViewCell.h"

@interface DetailTwoTableViewCell()
{
    UILabel *_stypeLabel;
    UILabel *_yearLabel;
    UILabel *_personLabel;
}

@end

@implementation DetailTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _stypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 100, 20)];
        _stypeLabel.textColor = [UIColor grayColor];
        _stypeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_stypeLabel];
        
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100, 5, 100, 20)];
        _yearLabel.textColor = [UIColor grayColor];
        _yearLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_yearLabel];
        
        _personLabel = [[UILabel alloc] init];
        _personLabel.textColor = [UIColor grayColor];
        _personLabel.tag = 1000;
        _personLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_personLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    _yearLabel.frame = CGRectMake(self.frame.size.width - 100, 5, 100, 20);
    _personLabel.frame = CGRectMake(5, 30, self.frame.size.width - 5, _personLabel.frame.size.height);
}

+(instancetype)createTableViewCellFromTableView:(UITableView *)tableView
{
    static NSString *str = @"cellTwo";
    DetailTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[DetailTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    return cell;
}

-(void)setMovie:(MovieDetailInfo *)movie
{
    if (_movie != movie) {
     
        _stypeLabel.text = movie.genres;
        
        _yearLabel.text =[NSString stringWithFormat:@"年代:%@", movie.year];
       
    
        if (self.flag == 1) {
            _personLabel.text = [NSString stringWithFormat:@"主演:%@\n", movie.tags];
        }else
        {
            _personLabel.text = [NSString stringWithFormat:@"主演:%@\n简介:%@", movie.tags,movie.intro];
            _personLabel.numberOfLines = 0;
        }
        CGFloat height = [XYMainFunction labelFitHeight:_personLabel.text label:_personLabel andFontSize:12];
        _personLabel.frame = CGRectMake(5, 30, self.frame.size.width - 5, height);
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
