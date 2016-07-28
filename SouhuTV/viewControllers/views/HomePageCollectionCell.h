//
//  HomePageCollectionCell.h
//  VideoText
//
//  Created by 何欣 on 15/6/9.
//  Copyright (c) 2015年 何欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieBaseInfo.h"

@interface HomePageCollectionCell : UICollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame;


@property(nonatomic,retain)MovieBaseInfo *baseInfo;

@end
