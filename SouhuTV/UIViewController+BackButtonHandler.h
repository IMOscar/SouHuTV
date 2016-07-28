//
//  UIViewController+BackButtonHandler.h
//  JavaPractice_app
//
//  Created by 肖野 on 15/5/13.
//  Copyright (c) 2015年 &#32918;&#37326;. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol<NSObject>

@optional

// Override this method in UIViewController derived class to handle 'Back' button click

-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end
