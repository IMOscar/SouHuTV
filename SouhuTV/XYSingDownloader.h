//
//  XYSingDownloader.h
//  ClassTest
//
//  Created by 肖野 on 15/6/14.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "XYDownload.h"

@interface XYSingDownloader : XYDownload

/**
 *  下载开始的位置
 */
@property (nonatomic, assign) long long begin;

/**
 *  结束（暂停）的位置
 */
@property (nonatomic, assign) long long end;
@end
