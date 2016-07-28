//
//  MoviewDetailInfo.m
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieDetailInfo.h"
#import "MoviePlayInfo.h"
@implementation MovieDetailInfo
- (void)dealloc
{
    [_title release];
    [_year release];
    [_rating release];
    [_type release];
    [_release_area release];
    [_playInfoArray release];
    [_poster release];
    [_are release];
    [_genres release];
    [_intro release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"submovies"]) {
        NSDictionary *dic = (NSDictionary *)value;
        NSString *key = [[dic allKeys] firstObject];
        for (NSDictionary *d in dic[key]) {
            MoviePlayInfo *object = [MoviePlayInfo moviePlayInfoWithDictionary:d];
            [_playInfoArray addObject:object];
        }
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _playInfoArray = [[NSMutableArray alloc] init];
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+(instancetype)moviewDetailInfoWithDictionary:(NSDictionary *)dictionary
{
    return [[[MovieDetailInfo alloc] initWithDictionary:dictionary] autorelease];
}

@end
