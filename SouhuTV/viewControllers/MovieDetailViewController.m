//
//  MovieDetailViewController.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "XYMainFunction.h"
@interface MovieDetailViewController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSUInteger _mumber;
    LOMovievView *_movieView;
}

@property (nonatomic, retain) MovieDetailInfo *movie;
@property (nonatomic, assign) BOOL SecondTap;
@property (nonatomic, assign) NSUInteger flag;
/**
 *  多线程队列
 */
@property (nonatomic, retain) XYMultiDownloader *multiDownloader;

@end

@interface MovieDetailViewController ()<BackButtonHandlerProtocol>
@property (nonatomic, retain) UIView *navigateView;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarHidden = YES;
    _flag = 1;
    _mumber = 2;
    
    [self setNavigationCustomerStyle];
    
    NSString *detailUrl = [NSString stringWithFormat:@"http://api.gougouvideo.com:8888/detail.php?id=%@&v=1.7.0",self.ID];
    NSLog(@"%@",detailUrl);
    
    [self getConnnection:detailUrl];

}

#pragma mark 导航栏样式
-(void)setNavigationCustomerStyle
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navigateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    _navigateView.backgroundColor = [UIColor clearColor];
    
    _titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.view.frame.size.width - 120, 30)];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = 1;
    [_navigateView addSubview:_titleLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"<首页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(turnBarck:) forControlEvents:UIControlEventTouchUpInside];
    [_navigateView addSubview:btn];
    
    [self.view addSubview:_navigateView];
}

#pragma mark 创建tableview
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height - 250) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:0.882 green:0.882 blue:0.902 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else
    {
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _mumber - 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
        else{
            //自适应cell
            CGFloat height;
            if (self.flag == 1) {
                height = [XYMainFunction labelFitHeight:[NSString stringWithFormat:@"主演:%@\n", self.movie.tags] andFontSize:12];
            }else
            {
                height = [XYMainFunction labelFitHeight:[NSString stringWithFormat:@"主演:%@\n简介:%@", self.movie.tags,self.movie.intro] andFontSize:12];
            }
            return 25 + height;
        }
    }
    else
    {
        return 90;
    }
}

#pragma mark 下载
-(XYMultiDownloader *)multiDownloader
{
    if (!_multiDownloader) {
        _multiDownloader = [[XYMultiDownloader alloc] init];
        
        NSString *url = ((MoviePlayInfo *)_detail.playInfoArray[0]).m3u8;
        //需要下载的文件远程URL
        _multiDownloader.url = url;
        //文件保存到什么地方
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.mov", _detail.title]];
        
        _multiDownloader.destPath = filePath;
    }
    return _multiDownloader;
}


-(void)startDownload
{
    [self.multiDownloader start];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DetailOneTableViewCell *cell =[DetailOneTableViewCell createTableViewCellByTableView:tableView];
            cell.movie = self.movie;
            
            //监听下载动作
            cell.downloadBlock = ^(MovieDetailInfo *downloadMovie)
            {
                _detail = downloadMovie;
                [self startDownload];
            };
            
            return cell;
        }else
        {
            DetailTwoTableViewCell *cell = [DetailTwoTableViewCell createTableViewCellFromTableView:tableView];
            cell.flag = self.flag;
            cell.movie = self.movie;
            return cell;
        }
    }
    else
    {
        DetailThreeTableViewCell *cell = [DetailThreeTableViewCell createTableViewCellFromTabelView:tableView];
        cell.movie = self.movie;
        cell.more = ^(NSArray *flag){
            [self createAllTelePlayView:flag];
        };
        cell.selecBlock = ^(NSUInteger index){
            MoviePlayInfo *play = _movie.playInfoArray[index];
            _movieView.url = play.m3u8;
            _titleLabel.text = [NSString stringWithFormat:@"%@第%ld集", self.movie.title, index + 1];
        };
        return cell;
    }
}

-(void)createAllTelePlayView:(NSArray *)flag
{
    AllTeleplayView *telePlayView = [[AllTeleplayView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height - 250)];
    telePlayView.array = flag;
    telePlayView.selecblock = ^(NSInteger index){
        MoviePlayInfo *play = _movie.playInfoArray[index - 1];
        _titleLabel.text = [NSString stringWithFormat:@"%@第%ld集", self.movie.title, index];
        _movieView.url = play.m3u8;
    };
    
    [self.view addSubview:telePlayView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        if (self.flag == 1) {
            self.flag = 2;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
            self.flag = 1;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

-(void)turnBarck:(id)sender
{
    [self navigationShouldPopOnBackButton];
}
#pragma mark 网络请求
-(void)getConnnection:(NSString *)url
{
    [GetConnection startConnection:url parmaters:nil connetionBlock:^(id responseObject) {
        _dic = (NSDictionary *)responseObject;
        
        if ([_dic[@"type"] isEqualToString:@"teleplay"]) {
            _mumber = 3;
        }
        [self createTableView];
        [self createLabel];
    }];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ([[UIApplication sharedApplication] statusBarOrientation] ==UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] ==UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"竖屏");
        _navigateView.hidden = YES;
    }else if([[UIApplication sharedApplication] statusBarOrientation] ==UIDeviceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight)
        
    {
        _navigateView.hidden = NO;
    }
}

-(void)createLabel
{
    self.movie = [MovieDetailInfo moviewDetailInfoWithDictionary:_dic];
    MoviePlayInfo *play = _movie.playInfoArray[0];
    
    _movieView = [[LOMovievView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) andMovieURLStr:play.m3u8];
    
    [self.view addSubview:_movieView];
    _titleLabel.text = self.movie.title;
    [self.view bringSubviewToFront:_navigateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)navigationShouldPopOnBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    return YES;
}

//iOS7以后用这个隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
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
