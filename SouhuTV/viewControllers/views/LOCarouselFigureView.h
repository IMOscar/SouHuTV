//
//  LOCarouselFigureView.h
//  VideoTest
//
//  Created by 肖野 on 15/6/9.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOPageControll.h"

@protocol LOCarouselFigureViewDelegate <NSObject>

@optional
-(void)tapImage:(NSUInteger)index;

@end

@interface LOCarouselFigureView : UIView <UIScrollViewDelegate, LOCarouselFigureViewDelegate>

{
    LOPageControll *_loPageControll;
    UIScrollView *_scrollView;
    UILabel *_textLabel;
}

@property (nonatomic, assign) id<LOCarouselFigureViewDelegate> delegate;

//* * * * * * * * * * * * * * *    label文本      * * * * * * * * * * * * * * * //
@property (nonatomic, retain) NSString *title;

//* * * * * * * * * * * * * * *     图片数组     * * * * * * * * * * * * * * * //
@property (nonatomic, retain) NSArray *imagesArray;

@property (nonatomic, assign) NSTimeInterval *timerInterval;

@property (nonatomic, assign) NSInteger currentImage;

@property (nonatomic, assign) NSTimer *random;

@end
