//
//  DetailThreeTableViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "DetailThreeTableViewCell.h"

@interface DetailThreeTableViewCell()<UIScrollViewDelegate>
{
    UIButton *_numberBtn;
    UIScrollView *_scrollView;
}

@end

@implementation DetailThreeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {


        _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_numberBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _numberBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_numberBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_numberBtn];
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        
        [self.contentView addSubview:_scrollView];
    }
    return self;
}

-(void)layoutSubviews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 30)];
    label.text = @"剧集";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [self.contentView addSubview:label];
    
    _numberBtn.frame = CGRectMake(self.frame.size.width - 90, 5, 80, 30);
    
    _scrollView.frame = CGRectMake(5, 45, self.frame.size.width - 10, 40);
}

-(void)setMovie:(MovieDetailInfo *)movie
{
    _movie = movie;
    _scrollView.contentSize = CGSizeMake(10 + 65 * movie.playInfoArray.count, 0);
    [_numberBtn setTitle:[NSString stringWithFormat:@"%ld集全>", movie.playInfoArray.count] forState:UIControlStateNormal];
    for (int i = 0; i < movie.playInfoArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.953 alpha:1];
        btn.frame = CGRectMake(5 + (5 + 60) * i, 0, 60, 30);
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.263 green:0.275 blue:0.282 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectTeleplay:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [_scrollView addSubview:btn];
    }
}

-(void)selectTeleplay:(UIButton *)sender
{
    self.selecBlock(sender.tag - 1000);
}

-(void)moreAction:(id)sender
{
    self.more(_movie.playInfoArray);
}

+(instancetype)createTableViewCellFromTabelView:(UITableView *)tableView
{
    static NSString *identify = @"cellThree";
    DetailThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[DetailThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
