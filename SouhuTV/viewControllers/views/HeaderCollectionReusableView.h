//
//  HeaderCollectionReusableView.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomePageSecondTypeBlok)(NSUInteger section);

@interface HeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) HomePageSecondTypeBlok tapedBlock;

@property (nonatomic, assign) NSUInteger section;

@property (nonatomic, retain) UILabel *classifyTitleLabel;

@property (nonatomic, assign) NSString *classifyTitle;

@end
