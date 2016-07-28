//
//  SearchTableViewCell.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYMainFunction.h"
#import "MovieSearch.h"
@interface SearchTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieSearch *search;

+(instancetype)createTableViewCellFromTabelView:(UITableView *)tableView;
@end
