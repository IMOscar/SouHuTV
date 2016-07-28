//
//  RootViewController.m
//  SouhuTV
//
//  Created by 启洋信息 on 16/4/11.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "RootViewController.h"
#import "XYMainFunction.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"http://60.18.250.166:8066/youme/service1.asmx/selectIsUserOk2Apple?U_no=13251746720&U_pass=19941016";
    [GetConnection startConnection:str parmaters:nil connetionBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
