//
//  AllTeleplayView.h
//  SouhuTV
//
//  Created by 肖野 on 15/6/12.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectWhichButton)(NSInteger index);

@interface AllTeleplayView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}

@property (nonatomic, retain) NSArray *array;

@property (nonatomic, copy) SelectWhichButton selecblock;

-(instancetype)initWithFrame:(CGRect)frame;

@end
