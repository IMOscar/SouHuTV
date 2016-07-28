//
//  XYSingDownloader.m
//  ClassTest
//
//  Created by 肖野 on 15/6/14.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "XYSingDownloader.h"

@interface XYSingDownloader () <NSURLConnectionDataDelegate>
/**
 *  连接对象
 */
@property (nonatomic, assign) NSURLConnection *connection;

/**
 *  写入数据的文件句柄
 */
@property (nonatomic, retain) NSFileHandle *writeHandle;

/**
 *  当前已经下载数据的长度
 */
@property (nonatomic, assign) long long currentLength;

@end

@implementation XYSingDownloader

-(NSFileHandle *)writeHandle
{
    if (!_writeHandle) {
        _writeHandle = [[NSFileHandle fileHandleForWritingAtPath:self.destPath] retain];
    }
    return _writeHandle;
}

/**
 *  开始（恢复）下载
 */
-(void)start
{
    NSURL *url = [NSURL URLWithString:self.url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求头信息
    NSString *value = [NSString stringWithFormat:@"bytes=%lld-%lld", self.begin + self.currentLength, self.end];
    [request setValue:value forHTTPHeaderField:@"Range"];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    _downloding = YES;
}

/**
 *  暂停下载
 */
-(void)pause
{
    [self.connection cancel];
    self.connection = nil;
    
    _downloding = NO;
}

/**
 *  当接受到服务器的数据就会调用NSUrlConnectionDataDelegate
 *
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //移动到文件的尾部
    [self.writeHandle seekToFileOffset:self.begin + self.currentLength];
    
    //从当前移动的位置（文件尾部）开始写入数据
    [self.writeHandle writeData:data];
    
    //累加长度
    self.currentLength += data.length;
    
    //打印下载进度
    double progress = (double)self.currentLength /(self.end - self.begin);
    if (self.progressHandler) {
        self.progressHandler(progress);
    }
}

/**
 *  当服务器数据请求结束后调用
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //清空当前属性值
    self.currentLength = 0;
    
    //关闭连接
    [self.writeHandle closeFile];
    self.writeHandle = nil;
    
}

@end
