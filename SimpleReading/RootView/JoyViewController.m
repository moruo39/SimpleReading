//
//  ZiHuViewController.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/3/29.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "JoyViewController.h"
#import "JoyViewModel.h"
#import "JoyFirstTableViewCell.h"
#import "JoySecondTableViewCell.h"
#import "MJRefresh.h"
#import "SWRevealViewController.h"
#import "JoyLeftViewController.h"
#import "JoyDetailViewController.h"


@interface JoyViewController ()<UITableViewDataSource,UITableViewDelegate,JoyLeftViewDelegate>

@property (nonatomic,retain)JoyViewModel *titleModel;

//@property (nonatomic,retain)NSMutableArray * titleArray;

@property (nonatomic,retain)NSMutableArray * DataArray;

@property (nonatomic,retain)UITableView * tableView;

//检查网络状态
@property (nonatomic,assign)BOOL isInNetWorking;
//加载页数
@property (nonatomic,assign)int page;
//数据id
@property (nonatomic,assign)int numId;

//titleView ui
@property (nonatomic,retain)UIView * titleView;
@property (nonatomic,retain)UIImageView * titleBgImage;
@property (nonatomic,retain)UILabel * titleLabel;
@property (nonatomic,retain)UILabel * sortLabel;


@end

@implementation JoyViewController

#pragma mark 懒加载

//-(NSMutableArray *)titleArray{
//    if (!_titleArray) {
//        _titleArray = [[NSMutableArray alloc]init];
//    }
//    return _titleArray;
//}


- (JoyViewModel *)titleModel{
    if (! _titleModel) {
        _titleModel = [[JoyViewModel alloc]init];
    }
    
    return _titleModel;
}

- (UIView *)titleView{
    
//    if (!_titleView) {
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height/3)];
    _titleView.backgroundColor = [UIColor whiteColor];
    
    _titleBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, _titleView.bounds.size.height/5*4)];
    
//    [_titleBgImage setImage:[UIImage imageNamed:@"123.jpg"]];
    
    NSArray * array = [_titleModel.pic componentsSeparatedByString:@"!"];
    
    [_titleBgImage sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
//    NSLog(@"%@",_titleModel.pic);
    
    [_titleView addSubview:_titleBgImage ];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_titleBgImage.frame)+5, Width-8, _titleView.bounds.size.height-5-_titleBgImage.bounds.size.height)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textColor = [UIColor blackColor];
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:_titleLabel.bounds.size.height/2.5];
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = _titleModel.title;
    [_titleView addSubview:_titleLabel];
    
    _sortLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_titleBgImage.frame)-20, 30, 15)];
    _sortLabel.textColor = [UIColor whiteColor];
    _sortLabel.backgroundColor = [UIColor colorWithRed:20/255.0 green:150/255.0 blue:190/255.0 alpha:1];
    _sortLabel.font = [UIFont systemFontOfSize:_sortLabel.bounds.size.height/1.5];
    _sortLabel.text = _titleModel.cat;
    _sortLabel.textAlignment = NSTextAlignmentCenter;
    [_titleBgImage addSubview:_sortLabel];
    
    _tableView.tableHeaderView = _titleView;
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [_titleView addGestureRecognizer:tapGesture];
    
    
//    }
    
    return _titleView;
}


-(NSMutableArray *)DataArray{

    if (! _DataArray) {
        _DataArray = [[NSMutableArray alloc]init];
    }
    return _DataArray;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.rowHeight = Height/5;
    
    
    [self.view addSubview:_tableView];
    
    
    [_tableView addHeaderWithTarget:self action:@selector(headerBegan)];
    
    _tableView.headerPullToRefreshText = @"下拉刷新额";
    _tableView.headerRefreshingText = @"正在刷新ing";
    _tableView.headerReleaseToRefreshText = @"松开就开始刷新额";
    
    [_tableView addFooterWithTarget:self action:@selector(footerBegan)];
    
    _tableView.footerPullToRefreshText = @"上拖加载额";
    _tableView.footerRefreshingText = @"正在加载ing";
    _tableView.footerReleaseToRefreshText = @"松开就开始加载额";
    
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"JoyFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellFirst"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"JoySecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellSecond"];
    }
    
    return _tableView;
    
}

#pragma mark ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _page = 1;
    _numId = 27;
    [self DataArray];
    [self tableView];
    
    //获取数据
    [self getData];
    
//    [self isInNetWorking];
    
    //注册该页面可以执行滑动切换
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 40, 50);
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
}

- (void)tapClick{
    
    JoyDetailViewController * detailVC = [[JoyDetailViewController alloc]init];
    
    detailVC.strID = _titleModel.Id;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


//- (void)loadLazy{
//    
//    [self DataArray];
//    [self tableView];
//    
//}

#pragma mark JoyLeftDelegate

- (void)JoyLeftClickWithChangerNum:(int)num{
    
    UIButton * button = (UIButton *)[self.view viewWithTag:1001];
    button.selected = NO;
    
    //是否让浮动层弹回原位
    SWRevealViewController *revealController = self.revealViewController;
    revealController.bounceBackOnOverdraw = YES;
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];

//    [_tableView scrollsToTop];
    
    _numId = num;
//    NSLog(@"%d",_numId);
    [self headerBegan];
}


#pragma mark tableView Delegate

- (void)headerBegan{
    
    _page = 1;
    
    [self getData];
    
    
}

- (void)footerBegan{
    _page ++;
    
    [self getData];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JoyDetailViewController * detailVC = [[JoyDetailViewController alloc]init];
    
    JoyViewModel * model = [_DataArray objectAtIndex:indexPath.row];
    
    detailVC.strID = model.Id;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    JoyViewModel * model = [_DataArray objectAtIndex:indexPath.row];
    if ([model.type intValue] == 1) {
        return  Height/2.5;
    }else{
        return Height/5.5;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JoyViewModel * model = [_DataArray objectAtIndex:indexPath.row];
    
    
    if ([model.type intValue] == 1) {
        
        static NSString * cellid = @"cellSecond";
        
        JoyFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"JoySecondTableViewCell" owner:self options:nil]firstObject];
        }
        
        [cell setDataWithModel:model];
            
        
        return cell;
        
        
        
    }else{
        
        static NSString * cellid = @"cellFirst";
        
        JoyFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"JoyFirstTableViewCell" owner:self options:nil]firstObject];
        }
        
            [cell setDataWithModel:model];
        
        return cell;
        
        
    }
        
    
    
}

#pragma mark 获取数据

//检查网络状态
- (void)getIsInNetWorking{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.isInNetWorking = (status == 1 || status == 2);
        [self getData];
    }];
    
   
}


//获取
- (void)getData{
    
  
    
    NSString * url = [NSString stringWithFormat:@"http://api.app.happyjuzi.com/v2.9/article/list/channel?id=%d&net=wifi&page=%d&pf=ios&res=375x667&size=20&uid=3960959803157179&ver=2.9.2",self.numId,self.page];
    
    [MyNetWorking getJoyViewDatawithUrl:url Success:^(id Data) {
       
//        banner内容
  
        if (_page == 1) {
            [_DataArray removeAllObjects];
        }
        
        NSDictionary * dict = [Data objectForKey:@"data"];
        NSArray * array = [dict objectForKey:@"info"];
        [self titleModel];
//        _titleModel = [[JoyViewModel alloc]init];
        
        for (NSDictionary * dic in array) {
            _titleModel.Id = [dic objectForKey:@"id"];
            _titleModel.title = [dic objectForKey:@"title"];
            _titleModel.pic = [dic objectForKey:@"pic"];
            _titleModel.publish_time = [dic objectForKey:@"publish_time"];
            _titleModel.readnum = [dic objectForKey:@"readnum"];
            _titleModel.cat = [dic objectForKey:@"cat"][@"name"];
            _titleModel.author = [dic objectForKey:@"author"][@"name"];
            
        }
        
        
        NSArray * tabArray = [dict objectForKey:@"list"];
        
        for (NSDictionary * di in tabArray) {
            JoyViewModel * model = [[JoyViewModel alloc]init];
            model.Id = [di objectForKey:@"id"];
            model.title = [di objectForKey:@"title"];
            model.pic = [di objectForKey:@"pic"];
            model.publish_time = [di objectForKey:@"publish_time"];
            model.readnum = [di objectForKey:@"readnum"];
            model.type = [di objectForKey:@"type"];
            model.cat = [di objectForKey:@"cat"][@"name"];
            model.author = [di objectForKey:@"author"][@"name"];
            
            [_DataArray addObject:model];
            
        }
//        NSLog(@"%ld",_DataArray.count);
        
        [self titleView];
        
        
        [_tableView reloadData];
        
        if (_page == 1) {
            [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }
        
        
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];

        
    } Fail:^(NSString *ErrorDer) {
        NSLog(@"%@",ErrorDer);
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
