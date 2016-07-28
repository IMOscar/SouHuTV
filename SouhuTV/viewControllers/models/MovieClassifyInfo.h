//
//  MovieClassifyInfo.h
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieClassifyInfo : NSObject

@property (nonatomic, retain) NSString *apiurl;

@property (nonatomic, retain) NSString *mTitle;

@property (nonatomic, retain) NSString *icon_url;

@property (nonatomic, retain) NSString *icon;

-(instancetype)initWithDictionary:(NSDictionary *)dicrionary;

+(instancetype)movieClassifyInfoWithDictionary:(NSDictionary *)dictionary;

@end
