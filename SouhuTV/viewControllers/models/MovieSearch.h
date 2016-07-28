//
//  MovieSearch.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieSearch : NSObject

@property (nonatomic, retain) NSString *ID;

@property (nonatomic, retain) NSString *poster;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *year;

@property (nonatomic, retain) NSString *tags;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

+(instancetype)movieSearchWithDictionary:(NSDictionary *)dictionary;


@end
