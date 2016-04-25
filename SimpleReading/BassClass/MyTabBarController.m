//
//  MyTabBarController.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyNavigationController.h"
#import "ClassViewController.h"
#import "JoyViewController.h"
#import "MyInfoViewController.h"
#import "SWRevealViewController.h"
#import "JoyLeftViewController.h"

@interface MyTabBarController ()

@property (nonatomic,retain)JoyLeftViewController * leftVC;
@property (nonatomic,retain)JoyViewController * joyVC;
@property (nonatomic,retain)SWRevealViewController * swrevealVC;
@property (nonatomic,assign)BOOL buttonSelect;

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    将automaticallyAdjustsScrollViewInsets设为NO,同时self.edgesForExtendedLayout = UIExtendedEdgeNone，那么UITableView的x，y为0，0时，不会被导航栏挡住，但是将不会有半透明的模糊效果）
    
    self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_bg_fold"]];
//    self.tabBar.tintColor = [UIColor colorWithRed:95/255.0 green:135/255.0 blue:250/255.0 alpha:1];
//    蓝
    
    self.tabBar.tintColor = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:75/255.0 alpha:1];

    
    //初始化子控制器
    [self addChildViewController:[[ClassViewController alloc]init] Title:@"阅读" ImageView:[UIImage imageNamed: @"navi_home"]];
//    添加joy视图里的左滑抽屉
    _leftVC = [[JoyLeftViewController alloc]init];
    _joyVC = [[JoyViewController alloc]init];
    _leftVC.delegate = _joyVC;
    _swrevealVC = [[SWRevealViewController alloc]initWithRearViewController:_leftVC frontViewController:_joyVC];
    //浮动层离左边距的宽度
    _swrevealVC.rearViewRevealWidth = Width/3;
    //    revealViewController.rightViewRevealWidth = 230;
    
    //是否让浮动层弹回原位
    //mainRevealController.bounceBackOnOverdraw = NO;
    [_swrevealVC setFrontViewPosition:FrontViewPositionLeft animated:YES];

    
    [self addChildViewController:_swrevealVC Title:@"娱乐" ImageView:[UIImage imageNamed:@"navi_brand"]];
    
    [self addChildViewController:[[MyInfoViewController alloc]init] Title:@"我" ImageView:[UIImage imageNamed:@"uesrNameIcon"]];
    
//    [self addChildViewController:[[FourthViewController alloc]init] Title:@"北美票房" ImageView:[UIImage imageNamed:@"uesrNameIcon"]];

    
//    self.selectedIndex = 2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addChildViewController:(UIViewController *)childController Title:(NSString * )title ImageView:(UIImage *)image{
    
    if ([childController isKindOfClass:[SWRevealViewController class] ]){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 100, 30);
        button.tag = 1001;
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"5_06.png"] forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
//        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        childController.navigationItem.titleView = button;
    }
    if ([childController isKindOfClass:[MyInfoViewController class] ]){
    
        childController.title = @"";
        childController.tabBarItem.title = @"我";
    
    }
    
    
    childController.title = title;
    childController.tabBarItem.image = image;
    
    //设置字体样式
    NSMutableDictionary * selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:95/255.0 green:135/255.0 blue:250/255.0 alpha:1];  蓝
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:120/255.0 green:210/255.0 blue:75/255.0 alpha:1];

    
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    MyNavigationController * nav = [[MyNavigationController alloc]initWithRootViewController:childController];
    // 添加为子控制器
    [self addChildViewController:nav];
    
    
}

- (void)buttonClick{
    
    self.buttonSelect = !_buttonSelect;
    
    //是否让浮动层弹回原位
    _swrevealVC.rearViewController = _leftVC;
    
    if (_buttonSelect == YES) {
        //是否让浮动层弹回原位
        _swrevealVC.bounceBackOnOverdraw = YES;
        [_swrevealVC setFrontViewPosition:FrontViewPositionRight animated:YES];
        
    }else{
        _swrevealVC.bounceBackOnOverdraw = YES;
        [_swrevealVC setFrontViewPosition:FrontViewPositionLeft animated:YES];
        
    }

    
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
