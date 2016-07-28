//
//  MoviePlayInfo.h
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviePlayInfo : NSObject

@property (nonatomic, retain) NSString *ID;

@property (nonatomic, retain) NSString *m3u8;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *number;

@property (nonatomic, retain) NSString *allow_download;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

+(instancetype)moviePlayInfoWithDictionary:(NSDictionary *)dictionary;

@end
