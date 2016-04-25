//
//  WebViewController.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/6.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,retain)WKWebView * webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _nameStr;
        
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    
    _webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds configuration:configuration];
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
//    监听
//    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    
    [self.view addSubview:_webView];
    
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    
}


#pragma mark kvo监听
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"loading"]) {
//        
////        NSLog(@"加载完成");
//    }else if ([keyPath isEqualToString:@"title"]){
//        
//    } else {
////        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
////}
////
////
//    
//}

- (void)dealloc{
    
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
