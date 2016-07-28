//
//  MovieListViewController.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListViewController : UIViewController

@property (nonatomic, assign) NSString *apiUrl;

@property (nonatomic, retain) NSArray *frontArray;

@property (nonatomic, assign) NSUInteger flag;
@end
