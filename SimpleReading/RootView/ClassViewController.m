//
//  ClassViewController.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/3/29.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "ClassViewController.h"
#import "YSLContainerViewController.h"
#import "FirstViewController.h"
#import "SecendViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ClassViewController ()<YSLContainerViewControllerDelegate>

//@property (nonatomic,copy)NSString * name;
//@property (nonatomic,copy)NSString * number;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    self.title = self.name;
    //
    [self loadUI];
    
}


#pragma mark 创建UI
- (void)loadUI{
    
//    UILabel * titleView = [[UILabel alloc]initWithFrame:CGRectZero];
//    titleView.font = [UIFont fontWithName:@"Futura-Medium" size:19];
//    titleView.textColor = [UIColor colorWithRed:0.333/255.0 green:0.333/255.0 blue:0.333/255.0 alpha:1];
//    titleView.text = self.name;
//    [titleView sizeToFit];
//    self.navigationItem.titleView = titleView;
    
    //返回按钮
//    UIButton * backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backbutton setBackgroundImage:[UIImage imageNamed:@"返回new"] forState:UIControlStateNormal];
//    backbutton.frame = CGRectMake(10, 30, 40, 40);
//    [backbutton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    //    [self.view addSubview:backbutton];
//    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:backbutton];
//    self.navigationItem.leftBarButtonItem = item;
    
    FirstViewController * firstVC = [[FirstViewController alloc]init];
    firstVC.title = @"电影";
//    firstVC.num = self.number;
    
    SecendViewController * secondVC = [[SecendViewController alloc]init];
    secondVC.title = @"杂谈";
//    secondVC.num = self.number;
    
    ThirdViewController * thirdVC = [[ThirdViewController alloc]init];
    thirdVC.title = @"音乐";
//    thirdVC.num = self.number;
    
    FourthViewController * fourthVC = [[FourthViewController alloc]init];
    fourthVC.title = @"文化";
//    fourthVC.num = self.number;
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController * containerVC = [[YSLContainerViewController alloc]initWithControllers:@[firstVC,secondVC,thirdVC,fourthVC] topBarHeight:statusHeight + navigationHeight parentViewController:self];
    
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    containerVC.menuItemSelectedTitleColor = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:75/255.0 alpha:1];
;
    containerVC.menuIndicatorColor = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:75/255.0 alpha:1];

    
    [self.view addSubview:containerVC.view];
    
}

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //    NSLog(@"current Index : %ld",(long)index);
    //    NSLog(@"current controller : %@",controller);
    
    //所控制的子视图控制器每被选择后就会调用其viewWillAppear方法
    
    [controller viewWillAppear:YES];
    
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
