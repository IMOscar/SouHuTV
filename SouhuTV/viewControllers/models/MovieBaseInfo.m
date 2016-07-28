//
//  MoviewBaseInfo.m
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieBaseInfo.h"

@implementation MovieBaseInfo

- (void)dealloc
{
    [_ID release];
    [_img release];
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

+(instancetype)movieBaseInfoWithDictionary:(NSDictionary *)dictionary
{
    return [[[MovieBaseInfo alloc] initWithDictionary:dictionary] autorelease];
}

@end
