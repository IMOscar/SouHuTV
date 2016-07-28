//
//  XYMainFunction.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "XYMainFunction.h"

@implementation XYMainFunction

//label自适应高度
+(CGFloat)labelFitHeight:(NSString *)str label:(UILabel *)label andFontSize:(CGFloat)fontSize
{
    label.numberOfLines = 0;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    label.font = font;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.text = str;
    
    NSDictionary  *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize actualsize = [str boundingRectWithSize:CGSizeMake(300.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return actualsize.height;
}

+(CGFloat)labelFitHeight:(NSString *)str andFontSize:(CGFloat)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    NSDictionary  *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize actualsize = [str boundingRectWithSize:CGSizeMake(300.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return actualsize.height;
}

@end
