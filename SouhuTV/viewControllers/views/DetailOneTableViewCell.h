//
//  DetailOneTableViewCell.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYMainFunction.h"

typedef void (^DetailDownloadBlock)(MovieDetailInfo *movie);

@interface DetailOneTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieDetailInfo *movie;

@property (nonatomic, copy) DetailDownloadBlock downloadBlock;

+(instancetype)createTableViewCellByTableView:(UITableView *)tableView;

@end
