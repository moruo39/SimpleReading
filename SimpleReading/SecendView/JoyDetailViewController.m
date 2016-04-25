//
//  JoyDetailViewController.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/15.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "JoyDetailViewController.h"
#import "JoyDetailModel.h"
#import "JoyDetailCollectionModel.h"
#import "JoyDetailTableViewCell.h"
#import "JoyDetailIMGModel.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>

@interface JoyDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate,WKNavigationDelegate>
//<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSString * url;
//检查网络状态
//@property (nonatomic,assign)BOOL isInNetWorking;
//tableview
//@property (nonatomic,retain)UITableView * tableView;
//dataArray
@property (nonatomic,retain)NSMutableArray * dataArray;


@property (nonatomic,retain)UILabel * titleLaber;
@property (nonatomic,retain)UILabel * timeLaber;
@property (nonatomic,retain)UILabel * nameLaber;
@property (nonatomic,retain)UILabel * typeLaber;
@property (nonatomic,retain)UIImageView * titleImage;
@property (nonatomic,retain)WKWebView * webView;

@property (nonatomic,retain)UIView *headView;



@end

@implementation JoyDetailViewController

//-(UITableView *)tableView{
//    
//    //    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
//    
//    if (!_tableView) {
//        
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, Width, Height -self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height) style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        [self.view addSubview:_tableView];
//    }
//    return _tableView;
//}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_background"]];
    
    
    _url = [NSString stringWithFormat:@"http://api.app.happyjuzi.com/v2.9/article/detail"];

    
    [SVProgressHUD showWithStatus:@"正在加载"];

    
    [self dataArray];
//    [self tableView];
    
    [self getData];
    
//    [self createUI];
    
    
//
    
}


- (void)createUI{
    
    int h = Height/5;
    
//    self.webView = [[UIWebView alloc]init];
//    self.webView.backgroundColor = [UIColor whiteColor];
//    self.webView.delegate= self;
//    self.webView.tag = 1;
//    self.webView.scrollView.delegate = self;
//    self.webView.frame = CGRectMake(0, 0, Width, Height);
    
    
//    [self.webView loadHTMLString:htmlUrl baseURL:nil];
//    [self.view addSubview:self.webView];
    
    
   
    
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), Width, Height) configuration:configuration];
    //    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(Height/2+h+44, 0, 0, 0);
    [self.view addSubview:self.webView];
    
    self.headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    _headView.frame = CGRectMake(0, -44 -h - Height/2, self.view.bounds.size.width,44+ h + Height/2);
    [self.webView.scrollView addSubview:_headView];

    //
//        self.webView.allowsBackForwardNavigationGestures = YES;
    
//    //获取UIWebBrowserView
//    UIView *webBrowserView = self.webView.scrollView.subviews[0];
//    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, Width, h + Height/2)];
//    
//    [self.webView addSubview:headerImageView];
//    
//    //改变UIWebBrowserView的坐标
//    CGRect frame = webBrowserView.frame;
//    frame.origin.y = CGRectGetMaxY(headerImageView.frame);
//    webBrowserView.frame = frame;
//    
//    //添加头部视图（这种情况头部视图不会随着webView的滚动而随着滚动，是固定的）
//    [self.webView sendSubviewToBack:headerImageView];
    
    //将视图添加到webView的ScrollView上
   
    
//
//
    

    
    self.titleLaber = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, Width-10, h/3*2)];
    self.titleLaber.font = [UIFont systemFontOfSize:h/7];
    self.titleLaber.numberOfLines = 0;
    [_headView addSubview:self.titleLaber];
    
    self.timeLaber = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    self.timeLaber.textColor = [UIColor grayColor];
    self.timeLaber.font = [UIFont systemFontOfSize:h/10];
    [_headView addSubview:self.timeLaber];
////
    self.nameLaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLaber.frame), CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    self.nameLaber.textColor = [UIColor grayColor];
    self.nameLaber.font = [UIFont systemFontOfSize:h/10];
    [_headView addSubview:self.nameLaber];
//
    
    if (self.nameLaber.bounds.size.width != 0) {
       self.typeLaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLaber.frame), CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    }else{
        self.typeLaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLaber.frame), CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    }
    
    self.typeLaber.textColor = [UIColor grayColor];
    self.typeLaber.font = [UIFont systemFontOfSize:h/10];
    [_headView addSubview:self.typeLaber];
//
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeLaber.frame), Width, Height/2)];
    [_headView addSubview:self.titleImage];

    
//  获取数据赋值
      [self setDataWithUI:_dataArray[0]];

    
}

- (void)setDataWithUI:(JoyDetailModel *)model{
    
    self.titleLaber.text = model.title;
    self.timeLaber.text = [NSString stringWithFormat:@"%@",model.publish_time];
    self.nameLaber.text = model.author;
    if ((model.type = nil)) {
        self.typeLaber.text = @"娱乐";
    }else{
        self.typeLaber.text = model.type;}
//
    NSArray * array = [model.img componentsSeparatedByString:@"!"];
//
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:array[0]]];
    
    
//    替换字符串
    NSString * str = [self filterHTML:model.contents];
    
    [self.webView loadHTMLString:str baseURL:nil];
    
//    [self reloadInputViews];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    
    
}

-(NSString *)filterHTML:(NSString *)html
{
    
    JoyDetailModel * model = _dataArray[0];
    NSArray * array = model.resources;
    
    for (int i = 0; i < array.count; i ++) {
        
    
        JoyDetailIMGModel * mod = array[i];
        NSString * str = mod.src;
        NSArray * arr = [str componentsSeparatedByString:@"!"];
        
//        NSScanner * scanner = [NSScanner scannerWithString:html];
        NSString * text = [NSString stringWithFormat:@"</p><p><!--IMG#%d--></p><p>",i];
        
        NSString * img = arr[0];
        NSArray * imgArr = [str componentsSeparatedByString:@"/"];
        
        NSString * strJpg = [imgArr lastObject];
        
        //替换的前缀和后缀
        NSString *regBegin = [NSString stringWithFormat:@"<\/p><p><img alt=\"%d.jpg\" src=\"",i];
        NSString *regEnd = [NSString stringWithFormat:@"\" title=\"%@\"\/><\/",strJpg];
        
        NSString * s = [NSString stringWithFormat:@"%@%@%@",regBegin,img,regEnd];

        NSMutableString * str2 = [NSMutableString stringWithString:html];
        html = [str2 stringByReplacingOccurrencesOfString:text withString:s];
        
//        while([scanner isAtEnd]==NO)
//        {
//            //找到标签的起始位置
//            //        </p><p><!--IMG#1--></p><p>
//            [scanner scanUpToString:@"</p><p><" intoString:nil];
//            //找到标签的结束位置
//            [scanner scanUpToString:@"></p><p>" intoString:&text];
//            //替换字符
//            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:s];
//        }
    
        
        

    }
//    NSLog(@"%@",html);


    
    
    return html;

    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    int i = (Height/2 + Height/5);
    
    _headView.frame = CGRectMake(0, - i - scrollView.contentOffset.y, Width, i);

    
    if (self.headView.frame.origin.y <= -i) {
        self.headView.frame = CGRectMake(0, - i, Width, -i);
    }
    if (self.headView.frame.origin.y >= 0) {
        self.headView.frame = CGRectMake(0, 0, Width, i);
    }
    
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame) + i, Width , Height - i - self.headView.frame.origin.y);
    

    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSLog(@"didFinishNavigation__");
    
    //    添加监听。监听数据是否加载完成
//        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];

    
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
//    NSLog(@"ddddd");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    NSLog(@"++++");

    //设置footerView的合理位置
    
//    CGSize contentSize = self.webView.scrollView.contentSize;
//    self.webView.scrollView.contentSize = CGSizeMake(contentSize.width, contentSize.height + Height/2);
//    UIView *view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, contentSize.height, self.view.bounds.size.width, Height/2);
//    view.backgroundColor = [UIColor redColor];
//    view.userInteractionEnabled = YES;
//    view.tag = 2;
//    [self.webView.scrollView addSubview:view];
    
    //取消监听，因为这里会调整contentSize，避免无限递归
//    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //设置footerView的合理位置
    //取消监听，因为这里会调整contentSize，避免无限递归
//    
//    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//
//    CGSize contentSize = self.webView.scrollView.contentSize;
//    NSLog(@"%f",self.webView.scrollView.contentSize.height);
//    
//    self.webView.scrollView.contentSize = CGSizeMake(contentSize.width, contentSize.height);
//    NSLog(@"%f",self.webView.scrollView.contentSize.height);
//    UIView *view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, contentSize.height, Width, Height/2);
//    view.backgroundColor = [UIColor redColor];
//    view.userInteractionEnabled = YES;
//    view.tag = 2;
//    [self.webView.scrollView addSubview:view];
//
    

    
}


//#pragma mark tableView
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    
////    FrSecendViewController * frSeVC = [[FrSecendViewController alloc]init];
////    frSeVC.model = _dataArray[indexPath.row];
////    [self.navigationController pushViewController:frSeVC animated:YES];
//    
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return Height;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return _dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString * cellid = @"cellid";
//    JoyDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//    if (cell == nil) {
//        cell = [[JoyDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//    }
//    
//    JoyDetailModel * model = [_dataArray objectAtIndex:indexPath.row];
////
////    cell.textLabel.text = model.title;
////    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
//    
//    [cell setDataWithModel:model];
//    
//    return cell;
//}


//#pragma mark getIsInNetWorking
//- (void)getIsInNetWorking{
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        self.isInNetWorking = (status==1||status==2);
//        //        NSLog(@"1111");
//        
//        [self getData];
//        
//    }];
//}


#pragma mark 获取数据
- (void)getData{
    
    [MyNetWorking getJoyDetailViewDatawithUrl:self.url andNum:self.strID Success:^(id Data) {
        
        NSDictionary * dict = [Data objectForKey:@"data"];
        JoyDetailModel * model = [[JoyDetailModel alloc]init];
        model.cat = [dict objectForKey:@"info"][@"id"];
        
        model.title = [dict objectForKey:@"info"][@"title"];
        
        NSDictionary * infoDic = [dict objectForKey:@"info"];
        
        model.type = [infoDic objectForKey:@"cat"][@"id"];
//        NSLog(@"%@",infoDic);
        
        model.author = [infoDic objectForKey:@"author"][@"username"];
        model.img = [infoDic objectForKey:@"img"];
        model.publish_time = [infoDic objectForKey:@"publish_time"];
        
        //html数据
        model.contents = [dict objectForKey:@"contents"];
        
        NSMutableArray * mArray = [[NSMutableArray alloc]init];
        
        NSArray * array = [dict objectForKey:@"footer"][@"recommend"];
        for (NSDictionary * dic in array) {
            JoyDetailCollectionModel * model = [[JoyDetailCollectionModel alloc]init];
            model.Id = [dic objectForKey:@"id"];
            model.title = [dic objectForKey:@"title"];
            model.img = [dic objectForKey:@"img"];
            model.urlroute = [dic objectForKey:@"urlroute"];
            
            [mArray addObject:model];
        }
//        foot数据
        model.recommend = mArray;
//        NSLog(@"%ld",mArray.count);
        
        NSArray * IMGArray = [dict objectForKey:@"resources"][@"IMG"];
        NSMutableArray * IMGmArray = [[NSMutableArray alloc]init];
        for (NSDictionary * IMGDic in IMGArray) {
            JoyDetailIMGModel * model = [[JoyDetailIMGModel alloc]init];
            model.src = [IMGDic objectForKey:@"src"];
            model.thumb = [IMGDic objectForKey:@"thumb"];
            model.width = [IMGDic objectForKey:@"width"];
            model.height = [IMGDic objectForKey:@"height"];
            
            [IMGmArray addObject:model];
        }
        
        model.resources = IMGmArray;
        
        [_dataArray addObject:model];
        
//        [_tableView reloadData];
        
//        [self setDataWithUI:model];

        [self createUI];
        
    } Fail:^(NSString *ErrorDer) {
        NSLog(@"%@",ErrorDer);
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
