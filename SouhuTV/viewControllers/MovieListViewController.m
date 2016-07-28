//
//  MovieListViewController.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieDetailViewController.h"
#import "XYMainFunction.h"
@interface MovieListViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BackButtonHandlerProtocol>
{
    UICollectionView *_collectionView;
    NSMutableArray *_array;
}
@end

@implementation MovieListViewController
-(instancetype)init
{
    if (self = [super init]) {
        _array = [[NSMutableArray alloc] init];
        _frontArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor magentaColor];
    [self createCollection];
}

-(void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 15) / 2 , 120);
    layout.minimumInteritemSpacing = 5;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:@"listCell"];
    
    [self.view addSubview:_collectionView];
}

-(void)setFrontArray:(NSArray *)frontArray
{
    [_array addObjectsFromArray:frontArray];
    [_collectionView reloadData];
}

-(void)setApiUrl:(NSString *)apiUrl
{
    [self getConnectionWith:apiUrl];
}
#pragma mark 网络请求
-(void)getConnectionWith:(NSString *)url
{
    [GetConnection startConnection:url parmaters:nil connetionBlock:^(id responseObject) {
        [_array addObjectsFromArray:responseObject];
        [_collectionView reloadData];
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _array.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    if (self.flag == 1) {
        cell.baseInfo = [MovieBaseInfo movieBaseInfoWithDictionary:_array[indexPath.row]];
    }else
    {
         cell.movie = [MovieDetailInfo moviewDetailInfoWithDictionary:_array[indexPath.row]];
    }
   
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailInfo *movie = [MovieDetailInfo moviewDetailInfoWithDictionary:_array[indexPath.row]];
    [self enternDetail:movie.ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)enternDetail:(NSString *)str
{
    MovieDetailViewController *detail = [[MovieDetailViewController alloc] init];
    detail.ID = str;
    
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

-(BOOL)navigationShouldPopOnBackButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    self.navigationController.navigationBar.hidden = NO;
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
