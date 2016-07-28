//
//  SearchViewController.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "SearchViewController.h"
#import "XYMainFunction.h"

#define SearchURL(str) [NSString stringWithFormat:@"http://api.gougouvideo.com:8888/search.php?q=%@&v=1.8.2&order=&offset=0&limit=30&v=1.8.2",str]

@interface SearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIButton *bigBtn;

@property (nonatomic, retain) UISearchBar *search;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _array = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor purpleColor];
    [self creatSearchBar];
    [self creatTabelView];
}
#pragma mark TabelView
-(void)creatTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView];
}

#pragma mark SearchBar
-(void)creatSearchBar
{
    _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _search.barStyle = UIBarStyleBlackTranslucent;
    
//    UIView *segment = [_search.subviews objectAtIndex:0];
//    [segment removeFromSuperview];
    _search.barTintColor = [UIColor whiteColor];
    
    _search.keyboardType = UIKeyboardAppearanceDefault;
    _search.placeholder = @"请输入关键字";
    _search.delegate = self;
    [self.view addSubview:_search];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bigBtn.frame = self.view.frame;
    [_bigBtn addTarget:self action:@selector(removeKeyBox:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_bigBtn];
    [self getConnection:SearchURL(searchBar.text)];
}
-(void)removeKeyBox:(id)sender
{
    [_search resignFirstResponder];
    
    [_bigBtn removeFromSuperview];
}

-(void)getConnection:(NSString *)url
{
    [GetConnection startConnection:url parmaters:nil connetionBlock:^(id responseObject) {
        [_search resignFirstResponder];
        [_array removeAllObjects];
        [_array addObjectsFromArray:(NSArray *)responseObject];
        [_tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [SearchTableViewCell createTableViewCellFromTabelView:tableView];
    MovieSearch *searchObj = [MovieSearch movieSearchWithDictionary:_array[indexPath.row]];
    cell.search = searchObj;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      MovieSearch *searchObj = [MovieSearch movieSearchWithDictionary:_array[indexPath.row]];
    [self enternDetail:searchObj.ID];
}

#pragma mark 进入详情
-(void)enternDetail:(NSString *)str
{
    MovieDetailViewController *detail = [[MovieDetailViewController alloc] init];
    detail.ID = str;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
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
