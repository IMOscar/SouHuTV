//
//  LOPageControll.h
//  VideoTest
//
//  Created by 肖野 on 15/6/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOPageControll : UIView

@property (nonatomic, assign) NSUInteger numberOfPages;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, retain) UIColor *tintColor;

@property (nonatomic, retain) UIColor *selectedTintColor;


-(instancetype)initWithFrame:(CGRect)frame andTintColor:(UIColor *)tintColor andSelectedTintColor:(UIColor *)selectedTintColor;

@end
