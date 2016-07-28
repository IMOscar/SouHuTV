//
//  DetailTwoTableViewCell.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/11.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYMainFunction.h"
@interface DetailTwoTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieDetailInfo *movie;

@property (nonatomic, assign) NSUInteger flag;

+(instancetype)createTableViewCellFromTableView:(UITableView *)tableView;
@end
