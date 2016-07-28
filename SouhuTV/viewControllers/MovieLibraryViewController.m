//
//  MovieLibraryViewController.m
//  SouhuTV
//
//  Created by 肖野 on 15/6/10.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MovieLibraryViewController.h"
#import "MovieListViewController.h"
#import "XYMainFunction.h"

static NSString *const classifyURL = @"http://api.gougouvideo.com:8888/channel.php?v=1.7.0";
static NSString *const topicsURL = @"http://api.gougouvideo.com:8888/topics/index.json?v=1.7.0";

@interface MovieLibraryViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_layout;
    NSMutableArray *_array;
    NSMutableArray *_secondArray;
}
@end

@implementation MovieLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _array = [[NSMutableArray alloc] init];
    _secondArray = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"片库";
    
    [self createCollectionView];
    [self getConnectionWithUrl:classifyURL];
    [self getConnectionWithUrl:topicsURL];
}
#pragma mark 网路请求
-(void)getConnectionWithUrl:(NSString *)url
{
    [GetConnection startConnection:url parmaters:nil connetionBlock:^(id responseObject) {
        if ([url isEqualToString:classifyURL]) {
            [_array addObjectsFromArray:responseObject];
            [_collectionView reloadData];
        }else
        {
            [_secondArray addObjectsFromArray:responseObject];
            [_collectionView reloadData];
        }
       
    }];
}

-(void)createCollectionView
{
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(self.view.frame.size.width / 3, 90);
    _layout.minimumInteritemSpacing = 0;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[LibraryCollectionViewCell class] forCellWithReuseIdentifier:@"libraryCell"];
    [_collectionView registerClass:[LibrarySecondCollectionViewCell class] forCellWithReuseIdentifier:@"librarySecondCell"];
    
    [self.view addSubview:_collectionView];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _array.count;
    }else
    {
        return _secondArray.count;
    }

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"libraryCell" forIndexPath:indexPath];
        cell.layer.borderColor=[UIColor colorWithRed:0.816 green:0.816 blue:0.827 alpha:1].CGColor;
        cell.layer.borderWidth=0.3;
        MovieClassifyInfo *classifyInfo = [MovieClassifyInfo movieClassifyInfoWithDictionary:_array[indexPath.row]];
        cell.classifyInfo = classifyInfo;
        return cell;
    }else
    {
        
        LibrarySecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"librarySecondCell" forIndexPath:indexPath];
        cell.layer.borderColor=[UIColor colorWithRed:0.816 green:0.816 blue:0.827 alpha:1].CGColor;
        cell.layer.borderWidth=0.3;
        MovieClassifyInfo *classifyInfo = [MovieClassifyInfo movieClassifyInfoWithDictionary:_secondArray[indexPath.row]];

        cell.mTitle = classifyInfo.mTitle;
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width / 3, 90);
    }else
    {
        return CGSizeMake(self.view.frame.size.width / 3 - 10, 30);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else
    {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
    {
        return 5;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MovieClassifyInfo *classifyInfo = [MovieClassifyInfo movieClassifyInfoWithDictionary:_array[indexPath.row]];
        
        [self enternList:classifyInfo.apiurl];
    }else
    {
        MovieClassifyInfo *topicUrl = [MovieClassifyInfo movieClassifyInfoWithDictionary:_secondArray[indexPath.row]];
        [self enternList:topicUrl.apiurl];
    }
}

-(void)enternList:(NSString *)apiUrl
{
    MovieListViewController *listVC = [[MovieListViewController alloc] init];
    listVC.apiUrl = apiUrl;
    [self.navigationController pushViewController:listVC animated:YES];
    [listVC release];
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
