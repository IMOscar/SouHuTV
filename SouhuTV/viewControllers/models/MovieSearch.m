//
//  MovieSearch.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieSearch.h"

@implementation MovieSearch

- (void)dealloc
{
    [_ID release];
    [_poster release];
    [_title release];
    [super dealloc];
}
//容错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+(instancetype)movieSearchWithDictionary:(NSDictionary *)dictionary
{
    return [[[MovieSearch alloc] initWithDictionary:dictionary] autorelease];
}

@end
