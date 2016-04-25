//
//  JoyLeftViewController.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/14.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "JoyLeftViewController.h"
#import "SWRevealViewController.h"
#import "JoyViewController.h"

@interface JoyLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;
//@property (nonatomic , assign) int dataId;
@property (nonatomic , strong) NSArray *menuArray;

@end

@implementation JoyLeftViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

-(void)initData{
    _menuArray = [NSArray arrayWithObjects:@"八卦",@"时尚",@"生活",@"影视",@"美妆",@"互动", nil];
}

-(void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height-64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TABLE_VIEW_ID = @"table_view_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_VIEW_ID];
    }
    cell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SWRevealViewController *revealViewController = self.revealViewController;
//    JoyViewController * joyVC = [[JoyViewController alloc]init];

    int dataId = 0;

    switch (indexPath.row) {
        case 0:
            dataId = 27;
            break;
        case 1:
            dataId = 26;
            break;
        case 2:
            dataId = 61;
            break;
        case 3:
            dataId = 32;
            break;
        case 4:
            dataId = 102;
            break;
        case 5:
            dataId = 95;
            break;
        default:
            break;
    }
    
//    NSLog(@"%d",dataId);
    
    [self JoyLeftClickNum:dataId];
        
    //调用pushFrontViewController进行页面切换
//    [revealViewController pushFrontViewController:joyVC animated:YES];
    
}

- (void) JoyLeftClickNum:(int)num{
    
    [self.delegate JoyLeftClickWithChangerNum:num];
}


//- (void)setDataWithBlock:(idBlock)block{

    
    
//}

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
