//
//  XYMainFunction.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HomePageCollectionCell.h"
#import "MovieLibraryViewController.h"
#import "MovieDetailViewController.h"
#import "SearchViewController.h"
#import "HistoryViewController.h"
#import "DownloadViewController.h"
#import "MovieListViewController.h"

#import "LOCarouselFigureView.h"
#import "LOPageControll.h"
#import "LOMovievView.h"
#import "HomePageCollectionCell.h"
#import "HomePageCollectionReusableView.h"
#import "HeaderCollectionReusableView.h"
#import "FooterCollectionReusableView.h"
#import "GetConnection.h"
#import "LibraryCollectionViewCell.h"
#import "LibrarySecondCollectionViewCell.h"
#import "ListCollectionViewCell.h"
#import "DetailOneTableViewCell.h"
#import "DetailTwoTableViewCell.h"
#import "DetailThreeTableViewCell.h"
#import "DownloadTableViewCell.h"
#import "SearchTableViewCell.h"
#import "AllTeleplayView.h"

#import "MovieBaseInfo.h"
#import "MoviePlayInfo.h"
#import "MovieClassifyInfo.h"
#import "MovieDetailInfo.h"
#import "MovieSearch.h"


#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

#import "UIViewController+BackButtonHandler.h"

#import "XYUtils.h"

#import "XYDownload.h"
#import "XYSingDownloader.h"
#import "XYMultiDownloader.h"

@interface XYMainFunction : NSObject

+(CGFloat)labelFitHeight:(NSString *)str label:(UILabel *)label andFontSize:(CGFloat)fontSize;

+(CGFloat)labelFitHeight:(NSString *)str andFontSize:(CGFloat)fontSize;
@end
