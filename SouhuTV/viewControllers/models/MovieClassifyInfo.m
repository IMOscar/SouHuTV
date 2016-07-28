//
//  MovieClassifyInfo.m
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieClassifyInfo.h"

@implementation MovieClassifyInfo

- (void)dealloc
{
    [_apiurl release];
    [_icon release];
    [_icon_url release];
    [_mTitle release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"title"]) {
        self.mTitle = value;
    }
}
-(instancetype)initWithDictionary:(NSDictionary *)dicrionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dicrionary];
    }
    return self;
}

+(instancetype)movieClassifyInfoWithDictionary:(NSDictionary *)dictionary
{
    return [[[MovieClassifyInfo alloc] initWithDictionary:dictionary] autorelease];
}
@end
