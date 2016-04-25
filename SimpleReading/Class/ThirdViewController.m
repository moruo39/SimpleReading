//
//  ThirdViewController.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "ThirdViewController.h"
#import "ThirdViewModel.h"
#import "SecendTableViewCell.h"
#import "WebViewController.h"

@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSString * url;
//检查网络状态
@property (nonatomic,assign)BOOL isInNetWorking;
//tableview
@property (nonatomic,retain)UITableView * tableView;
//dataArray
@property (nonatomic,retain)NSMutableArray * dataArray;

@end

@implementation ThirdViewController

#pragma mark 懒加载
-(UITableView *)tableView{
    if (!_tableView) {

    //    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 - 30 * Factor, Width, Height - 85 * Factor -self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {

        _dataArray = [[NSMutableArray alloc]init];
    }
        return _dataArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getIsInNetWorking];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_background"]];
    
    _url = @"http://graph.luoo.net/essay/search?key=b1f6036605975a63b660acfeb252594c&page=1&platform=ios";
    
    
    [self tableView];
    [self dataArray];
//    [self getData];
    
//        [self getIsInNetWorking];
    
}

#pragma mark tableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController * webVC = [[WebViewController alloc]init];
    ThirdViewModel * model = _dataArray[indexPath.row];
    webVC.url = [NSString stringWithFormat:@"%@",model.essay_url];
    webVC.nameStr = @"音乐";
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Height/5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"cellid";
    SecendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[SecendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    ThirdViewModel * model = [_dataArray objectAtIndex:indexPath.row];
    
    [cell setDataWithThirdModel:model];
    
    return cell;
}


#pragma mark getIsInNetWorking
- (void)getIsInNetWorking{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.isInNetWorking = (status==1||status==2);
        //        NSLog(@"1111");
        
        [self getData];
        
    }];
}


#pragma mark 获取数据
- (void)getData{
    
    [MyNetWorking getThirdViewDatawithUrl:_url Success:^(id Data) {
        
        //解析数据
        
        NSArray * array = [Data objectForKey:@"data"][@"items"];
        //kvc
        for (NSDictionary * dict in array) {
        ThirdViewModel * model = [[ThirdViewModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
//            NSLog(@"%@",model.title);
        [_dataArray addObject:model];
        }
        
//        NSLog(@"%ld",_dataArray.count);
        
        [_tableView reloadData];
        
        
    } Fail:^(NSString *ErrorDes) {
        NSLog(@"%@",ErrorDes);
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
