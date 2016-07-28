//
//  XYDownload.h
//  ClassTest
//
//  Created by 肖野 on 15/6/14.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDownload : NSObject
{
    //标记是否为下载状态
    BOOL _downloding;
}
/**
 *  所需下载文件的远程URL
 */
@property (nonatomic, assign) NSString *url;

/**
 *  文件的存储路径（本地的url）
 */
@property (nonatomic, retain) NSString *destPath;

/**
 *  是否正在下载（有没有在下载，只有下载器内部知道）
 */
@property (nonatomic, readonly, getter=isDownloading) BOOL downloading;

/**
 *  监听下载进度
 */
@property (nonatomic, copy) void (^progressHandler)(double progress);

/**
 *  开始（恢复）下载
 */
-(void)start;

/**
 *  暂停下载
 */
-(void)pause;

@end
