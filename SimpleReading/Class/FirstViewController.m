//
//  FirstViewController.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstViewModel.h"
#import "FirstTableViewCell.h"
#import "FrSecendViewController.h"
#import "DataBaseManager.h"


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSString * url;
//检查网络状态
@property (nonatomic,assign)BOOL isInNetWorking;
//tableview
@property (nonatomic,retain)UITableView * tableView;
//dataArray
@property (nonatomic,retain)NSMutableArray * dataArray;

@property (nonatomic,retain)DataBaseManager * dataBase;

@end

@implementation FirstViewController

-(UITableView *)tableView{
    
//    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    if (!_tableView) {
    
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

-(DataBaseManager *)dataBase{
    
    [_dataBase dataBase];
    
    
    return _dataBase;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getIsInNetWorking];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_background"]];
        
    _url = @"https://api.douban.com/v2/movie/in_theaters";
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    [self tableView];
    [self dataArray];
//    [self getIsInNetWorking];
    
}

#pragma mark tableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FrSecendViewController * frSeVC = [[FrSecendViewController alloc]init];
    frSeVC.model = _dataArray[indexPath.row];
    [self.navigationController pushViewController:frSeVC animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Height/5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"cellid";
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    FirstViewModel * model = [_dataArray objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = model.title;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
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
    
    [MyNetWorking getFirstViewDatawithUrl:_url Success:^(id Data) {
        
        //解析数据
        //        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"3333");
        
        NSArray * array = [Data objectForKey:@"subjects"];
        for (NSDictionary * dict in array) {
            FirstViewModel * model = [[FirstViewModel alloc]initWithDict:dict];
            
//            FirstViewModel * model = [FirstViewModel modelwithDict:dict];
            [_dataArray addObject:model];
            
//            NSLog(@"%@",_dataArray[0]);
//            [_tableView reloadData];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // time-consuming task
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
            
            
        }
        
        if (_dataArray.count == 20) {
            [_tableView reloadData]; 
        }
        
        
    } Fail:^(NSString *ErrorDes) {
        NSLog(@"%@",ErrorDes);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // time-consuming task
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        });
        
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    
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
