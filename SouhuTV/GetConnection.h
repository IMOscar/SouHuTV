//
//  GetConnection.h
//  aiai
//
//  Created by 肖野 on 14-9-12.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^connectionBlock)(id responseObject);


@interface GetConnection : NSObject

@property (nonatomic, strong) connectionBlock block;

+(void)startConnection:(NSString *)url parmaters:(NSDictionary *)par connetionBlock:(connectionBlock)block;

-(void)connectionWith:(NSString *)url parmaters:(NSDictionary *)par connectionBlock:(connectionBlock)block;

@end
