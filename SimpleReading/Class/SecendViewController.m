//
//  SecendViewController.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "SecendViewController.h"
#import "SecendViewModel.h"
#import "SecendTableViewCell.h"
#import "WebViewController.h"

@interface SecendViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSString * url;
//检查网络状态
@property (nonatomic,assign)BOOL isInNetWorking;
//tableview
@property (nonatomic,retain)UITableView * tableView;
//dataArray
@property (nonatomic,retain)NSMutableArray * dataArray;

@end

@implementation SecendViewController

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
    
    _url = @"http://static.owspace.com/index.php?m=Home&c=Api&a=getList&model=1&p=1&client=iphone&page_id=0&create_time=0&device_id=815032F6-3512-4034-980F-129AE6219AF6&iOS_version=1.1.0";
    
    
    [self tableView];
    [self dataArray];
//    [self getData];

//    [self getIsInNetWorking];
    
}

#pragma mark tableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController * webVC = [[WebViewController alloc]init];
    SecendViewModel * model = _dataArray[indexPath.row];
    webVC.url = [NSString stringWithFormat:@"http://static.owspace.com/wap/%@.html?device_id=815032F6-3512-4034-980F-129AE6219AF6&version=iOS_1.1.0&client=iOS",model.nid];
    webVC.nameStr = @"杂谈";
    
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
    
    SecendViewModel * model = [_dataArray objectAtIndex:indexPath.row];
    
    [cell setDataWithModel:model];
    
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
    
    [MyNetWorking getSecendViewDatawithUrl:_url Success:^(id Data) {
        
        //解析数据
        //        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingMutableContainers error:nil];
        
        //        NSLog(@"3333");
        
        NSArray * array = [Data objectForKey:@"datas"];
        for (NSDictionary * dict in array) {
            SecendViewModel * model = [[SecendViewModel alloc]initWithDict:dict];
            
            //            FirstViewModel * model = [FirstViewModel modelwithDict:dict];
            [_dataArray addObject:model];
            
//                        NSLog(@"%@",_dataArray[0]);
            //            [_tableView reloadData];
            
            
        }
        
//        if (_dataArray.count < ) {
            [_tableView reloadData];
//        }
        
        
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
