//
//  MoviewDetailInfo.h
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailInfo : NSObject

@property (nonatomic, retain) NSString * year;

@property (nonatomic, retain) NSString * type;

@property (nonatomic, retain) NSString * rating;

@property (nonatomic, retain) NSString * are;

@property (nonatomic, retain) NSString * genres;

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * poster;

@property (nonatomic, retain) NSString * intro;

@property (nonatomic, retain) NSString * release_area;

@property (nonatomic, retain) NSString * ID;

@property (nonatomic, retain) NSMutableArray *playInfoArray;

@property (nonatomic, retain) NSString * tags;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

+(instancetype)moviewDetailInfoWithDictionary:(NSDictionary *)dictionary;

@end
