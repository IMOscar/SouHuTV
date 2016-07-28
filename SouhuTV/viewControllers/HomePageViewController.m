//
//  HomePageViewController.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "HomePageViewController.h"
#import "RootViewController.h"
#import "XYMainFunction.h"

static NSString * const lunboUrl = @"http://api.gougouvideo.com:8888/index_focus.php?v=1.8.2";
static NSString * const homePageUrl = @"http://api.gougouvideo.com:8888/index_lists.php?v=1.7.0";

@interface HomePageViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) NSMutableArray *imagesArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = NO;
    // Do any additional setup after loading the view.
    
    //改变tabbar浅景色
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    _array = [[NSMutableArray alloc] init];
    _imagesArray = [[NSMutableArray alloc] init];
    
    
    [self createNavigationStyle];
    [self createNavigation];
    [self getConnection:lunboUrl];
    [self getConnection:homePageUrl];
}

-(void)createNavigation
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 15) / 2 , 120);
    layout.minimumInteritemSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //注册cell
    [_collectionView registerClass:[HomePageCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    //注册collection头视图 CollectionReusableView注册
    [_collectionView registerClass:[HomePageCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CarouselFigure"];
    
    //注册footer
    [_collectionView registerClass:[FooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    
    [_collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
    
    
    [self.view addSubview:_collectionView];
}


#pragma mark 解析数据
-(void)getConnection:(NSString *)url
{
    [GetConnection startConnection:url parmaters:nil connetionBlock:^(id responseObject) {
        if ([url isEqualToString:homePageUrl]) {
            [_array addObjectsFromArray:(NSArray *)responseObject];
            [_collectionView reloadData];
        }else
        {
            [_imagesArray addObjectsFromArray:(NSArray *)responseObject];
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            for (NSDictionary * dic in _imagesArray) {
                MovieBaseInfo * base = [MovieBaseInfo movieBaseInfoWithDictionary:dic];
                [mArray addObject:base];
            }
            [_imagesArray removeAllObjects];
            [_imagesArray addObjectsFromArray:mArray];
            ;
        }
    }];
}

#pragma mark 返回header,footer视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionFooter) {
        FooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        return footer;
    }
    
    if (indexPath.section == 0) {
        HomePageCollectionReusableView *reusableView = nil;
        
        if (kind == UICollectionElementKindSectionHeader){
            
            HomePageCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CarouselFigure" forIndexPath:indexPath];
 
            headerView.section = indexPath.section;
            
            headerView.imagesArray = _imagesArray;
            
            headerView.classifyTitle = _array[indexPath.section][@"title"];
            
            headerView.selectedBlock = ^(NSUInteger index){
                MovieBaseInfo *info = _imagesArray[index];
                [self enternDetail:info.ID];
            };
            
            headerView.tapedBlock = ^(NSUInteger section){
              [self enternList:(NSArray *)_array[section][@"data"]];
            };
            reusableView = headerView;
        }
        return reusableView;
    }else
        
    {
        HeaderCollectionReusableView *reusableView = nil;
        if (kind == UICollectionElementKindSectionHeader) {
            HeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
            header.section = indexPath.section;
            
            header.tapedBlock = ^(NSUInteger section){
              [self enternList:(NSArray *)_array[section][@"data"]];
            };
            
            header.classifyTitle = _array[indexPath.section][@"title"];
            reusableView = header;
        }
        return reusableView;
    }
}

//设置cell边距  上 左 下 右  逆时针方向
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}

//设置cell纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

#pragma mark 返回sectionHeader尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return   CGSizeMake(collectionView.frame.size.width, 180);
    }else
    {
        return   CGSizeMake(collectionView.frame.size.width, 40);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 10);
}

//section数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _array.count;
}

//cell数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //全部数据
    //return ((NSArray *)self.array[section][@"data"]).count;
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.baseInfo = [MovieBaseInfo movieBaseInfoWithDictionary:_array[indexPath.section][@"data"][indexPath.row]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieBaseInfo *baseInfo = [MovieBaseInfo movieBaseInfoWithDictionary:_array[indexPath.section][@"data"][indexPath.row]];
    [self enternDetail:baseInfo.ID];
}

#pragma mark 进入列表页面
-(void)enternList:(NSArray *)array
{
    MovieListViewController *listVC = [[MovieListViewController alloc] init];
    listVC.frontArray = array;
    listVC.flag = 1;
    [self setBachButtonItemTitle];
    [self.navigationController pushViewController:listVC animated:YES];
    [listVC release];
}


#pragma mark 导航栏样式
-(void)createNavigationStyle{
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *historyItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navigation-Btn-History-Normal"] landscapeImagePhone:[UIImage imageNamed:@"Navigation-Btn-History-Highlighted"] style:UIBarButtonItemStyleDone target:self action:@selector(showHistory)];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navigation-Btn-Search-Normal"] landscapeImagePhone:[UIImage imageNamed:@"Navigation-Btn-Search-Highlighted"] style:UIBarButtonItemStyleDone target:self action:@selector(showSearch)];
    
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo-horizontal"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = logo;
    
    self.navigationItem.rightBarButtonItems = @[searchItem, historyItem];
}

#pragma mark 历史播放
-(void)showHistory
{
    HistoryViewController *history = [[HistoryViewController alloc] init];
    [self.navigationController pushViewController:history animated:YES];
}
#pragma mark 搜索
-(void)showSearch
{
    [self setBachButtonItemTitle];
//    SearchViewController *search = [[SearchViewController alloc] init];
//    PUSH(search);
    RootViewController *root = [RootViewController new];
    PUSH(root);
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

#pragma mark - 设置下一页返回按钮的标题
-(void)setBachButtonItemTitle{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    backItem.title = @"首页";
    
    self.navigationItem.backBarButtonItem = backItem;
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
