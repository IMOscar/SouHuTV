//
//  GetConnection.m
//  aiai
//
//  Created by 肖野 on 14-9-12.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import "GetConnection.h"
#import "XYMainFunction.h"
@implementation GetConnection

+(void)startConnection:(NSString *)url parmaters:(NSDictionary *)par connetionBlock:(connectionBlock)block
{
    GetConnection *roots = [[GetConnection alloc] init];
    [roots connectionWith:url parmaters:par connectionBlock:block];
}

-(void)connectionWith:(NSString *)url parmaters:(NSDictionary *)par connectionBlock:(connectionBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:url parameters:par success:^(AFHTTPRequestOperation *operation, id responseObject) {

        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
