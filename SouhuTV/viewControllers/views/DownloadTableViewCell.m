//
//  DownloadTableViewCell.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "DownloadTableViewCell.h"

@implementation DownloadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)createCellFromDownloadTableViewCell:(UITableView *)tablView
{
    static NSString *indentify = @"DownloadTableViewCell";
    DownloadTableViewCell *cell = [tablView dequeueReusableCellWithIdentifier:indentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DownloadTableViewCell" owner:nil options:nil]firstObject];
    }
    return cell;
}


- (void)dealloc {
    [_runBtn release];
    [_currentState release];
    [_titleLabel release];
    [_cacheLabel release];
    [_secondTitle release];
    [_percentLabel release];
    [super dealloc];
}
@end
