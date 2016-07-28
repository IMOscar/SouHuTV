//
//  HomePageCollectionReusableView.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOCarouselFigureView.h"

typedef  void (^HomePageCollectionReusableViewBlock)(NSUInteger index);
typedef void (^HomePageWichSectionTaped)(NSUInteger section);

@interface HomePageCollectionReusableView : UICollectionReusableView <LOCarouselFigureViewDelegate>


@property (nonatomic, copy) HomePageCollectionReusableViewBlock selectedBlock;
@property (nonatomic, copy) HomePageWichSectionTaped tapedBlock;

@property (nonatomic, assign) NSUInteger section;

@property (nonatomic, retain) NSArray *imagesArray;

@property (nonatomic, assign) NSString *classifyTitle;

@property (nonatomic, assign) UILabel *classifyTitleLabel;

//-(instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray andTitelArray:(NSArray *)titleArray;

@end
