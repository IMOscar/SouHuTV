//
//  ListCollectionViewCell.h
//  
//
//  Created by 肖野 on 15/6/11.
//
//

#import <UIKit/UIKit.h>
#import "XYMainFunction.h"
#import "MovieDetailInfo.h"
@interface ListCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) MovieDetailInfo *movie;

@property (nonatomic, retain) MovieBaseInfo *baseInfo;

@end
