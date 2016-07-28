//
//  XYMultiDownloader.m
//  ClassTest
//
//  Created by 肖野 on 15/6/14.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "XYMultiDownloader.h"
#import "XYSingDownloader.h"

#define MaxDownloadCount 4

@interface XYMultiDownloader()

/**
 *  下载进程队列
 */
@property (nonatomic, retain) NSMutableArray *singleDownloader;

@property (nonatomic, assign) long long totalLength;

@end

@implementation XYMultiDownloader

-(void)getFileSize
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    request.HTTPMethod = @"HEAD";
    
    NSURLResponse *response = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    self.totalLength  = response.expectedContentLength;
}

- (NSMutableArray *)singleDownloader
{
   if (!_singleDownloader) {
         _singleDownloader = [NSMutableArray array];

        // 获得文件大小
       [self getFileSize];

       // 每条路径的下载量
       long long size = 0;
       
        if (self.totalLength % MaxDownloadCount == 0) {
           size = self.totalLength / MaxDownloadCount;
        } else {
           size = self.totalLength / MaxDownloadCount + 1;
        }

       // 创建N个下载器
        for (int i = 0; i < MaxDownloadCount; i++) {
            XYSingDownloader *singleDownloader = [[XYSingDownloader alloc] init];
            singleDownloader.url = self.url;
            singleDownloader.destPath = self.destPath;
            singleDownloader.begin = i * size;
            singleDownloader.end = singleDownloader.begin + size - 1;
            singleDownloader.progressHandler = ^(double progress){
               NSLog(@"%d --- %f", i, progress);
             };
            [_singleDownloader addObject:singleDownloader];
       }
        // 创建一个跟服务器文件等大小的临时文件
       [[NSFileManager defaultManager] createFileAtPath:self.destPath contents:nil attributes:nil];

       // 让self.destPath文件的长度是self.totalLengt
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.destPath];
       [handle truncateFileAtOffset:self.totalLength];
    }
  return _singleDownloader;
}

/**
 * 开始(恢复)下载
*/
- (void)start
{
   [self.singleDownloader makeObjectsPerformSelector:@selector(start)];
   _downloding = YES;
}
/**
 * 暂停下载
*/
- (void)pause
{
     [self.singleDownloader makeObjectsPerformSelector:@selector(pause)];
     _downloding = NO;
}

@end
