//
//  MoviePlayInfo.m
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MoviePlayInfo.h"

@implementation MoviePlayInfo

- (void)dealloc
{
    [_ID release];
    [_m3u8 release];
    [_title release];
    [_number release];
    [_allow_download release];
    [super dealloc];
}
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

+(instancetype)moviePlayInfoWithDictionary:(NSDictionary *)dictionary
{
    return [[[MoviePlayInfo alloc] initWithDictionary:dictionary] autorelease];
}
@end
