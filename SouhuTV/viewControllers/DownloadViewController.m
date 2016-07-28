//
//  DownloadViewController.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "DownloadViewController.h"
#import "MovieDetailViewController.h"
@interface DownloadViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_array;
    
}
@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _array = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    
    


    [self createNavigationViewStype];
    [self createTableView];
}


-(void)createNavigationViewStype
{
    NSArray *array=@[@"未完成",@"已完成"];
    UISegmentedControl *segmentControl=[[UISegmentedControl alloc]initWithItems:array];
//    segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, 0, 180, 35);
    //默认选择
    segmentControl.selectedSegmentIndex = 0;
    //设置背景色
    segmentControl.tintColor=[UIColor blueColor];
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentControl;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAction:)];
    self.navigationItem.rightBarButtonItem = btn;
}
#pragma mark segment点击事件
-(void)change:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        [_array removeAllObjects];
        [_array addObjectsFromArray:[[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil]];
        [_tableView reloadData];
    }else
    {
        [_array removeAllObjects];
        [_array addObjectsFromArray:[[NSArray alloc] initWithObjects:@"", nil]];
        [_tableView reloadData];
    }
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadTableViewCell *downloadCell = [DownloadTableViewCell createCellFromDownloadTableViewCell:tableView];
    return downloadCell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_array removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

-(void)deleteAction:(id)sender
{
    [_tableView setEditing:!_tableView.editing animated:YES];
    
    if (_tableView.editing)
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"删除"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)enternDetail:(id)sender
{
    MovieDetailViewController *detail = [[MovieDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
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
