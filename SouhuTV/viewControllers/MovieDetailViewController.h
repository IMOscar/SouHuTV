//
//  MovieDetailViewController.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYMainFunction.h"
#import "MovieDetailInfo.h"


typedef void (^MovieDetailDownloadBlock)(MovieDetailInfo *downloadMovie);

@interface MovieDetailViewController : UIViewController

@property (nonatomic, assign) NSString *ID;

@property (nonatomic, retain) MovieDetailInfo *detail;

@property (nonatomic, retain) NSDictionary *dic;

@property (nonatomic, retain) UILabel *titleLabel;

/**
 *  下载block，传值给AppDelegate
 */
@property (nonatomic, copy) MovieDetailDownloadBlock movieDetailBlock;

@end
