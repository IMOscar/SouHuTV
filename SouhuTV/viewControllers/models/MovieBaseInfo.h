//
//  MoviewBaseInfo.h
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieBaseInfo : NSObject

@property (nonatomic, retain) NSString *ID;

@property (nonatomic, retain) NSString *img;

@property (nonatomic, retain) NSString *title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

+(instancetype)movieBaseInfoWithDictionary:(NSDictionary *)dictionary;

@end
