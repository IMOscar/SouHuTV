//
//  DetailThreeTableViewCell.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYMainFunction.h"

typedef void (^MoreBlock)(NSArray *flag);
typedef void (^SelectBlock)(NSUInteger index);

@interface DetailThreeTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieDetailInfo *movie;

@property (nonatomic, copy) MoreBlock more;
@property (nonatomic, copy) SelectBlock selecBlock;

+(instancetype)createTableViewCellFromTabelView:(UITableView *)tableView;

@end
