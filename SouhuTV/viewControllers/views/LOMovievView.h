//
//  LOMovievView.h
//  VideoTest
//
//  Created by 肖野 on 15/6/9.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface LOMovievView : UIView

/**
 *  初始化视频播放器方法
 *
 *  @param frame     视频播放frame
 *  @param urlString 视频播放地址
 */
-(instancetype)initWithFrame:(CGRect)frame andMovieURLStr:(NSString *)urlString;
/**
 *  电影名
 */
@property (nonatomic, assign) NSString *url;
@property (nonatomic, assign) NSString *title;

@end
