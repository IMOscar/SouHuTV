//
//  DownloadTableViewCell.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *runBtn;
@property (retain, nonatomic) IBOutlet UILabel *currentState;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *cacheLabel;
@property (retain, nonatomic) IBOutlet UILabel *secondTitle;
@property (retain, nonatomic) IBOutlet UILabel *percentLabel;

+(instancetype)createCellFromDownloadTableViewCell:(UITableView *)tablView;

@end
