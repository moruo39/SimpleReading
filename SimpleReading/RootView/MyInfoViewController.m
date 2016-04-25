//
//  MyInfoViewController.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/3/29.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyCell.h"
#import "WebViewController.h"

@interface MyInfoViewController ()

@property (nonatomic,strong)NSArray *myViewArray;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)NSArray *urlID;


@end

@implementation MyInfoViewController

- (NSArray *)myViewArray{
    if (_myViewArray == nil) {
        _myViewArray = @[@"我的信息",@"我的收藏",@"我的分享",@"关于",@"反馈"];
    }
    return _myViewArray;
}
- (NSArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = @[@"button_submission",@"navi_fav",@"article_share",@"navi_about",@"navi_chat"];
    }
    return _imageArray;
}
- (NSArray *)urlID{
    if (_urlID == nil) {
        _urlID = @[@"",@"Collection",@"Share",@"2",@"97"];
    }
    return _urlID;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = nil
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_background"]];
    self.imageBG.image = [UIImage imageNamed:@"navi_logo"];
    self.headImageView.image = [UIImage imageNamed:@"myheadimage.jpeg"];
    self.nameLabel.text = @"游客";
    self.rightBtn.hidden = YES;
    self.leftBtn.hidden = YES;
    [self setupTableView];
}
#pragma mark setupTableView
- (void)setupTableView{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_background"]];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -80, 0, 0);
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = bgView;
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myViewArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"myViewCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.myViewArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"暂无信息" message:@"敬请期待" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
        }
            break;
        case 3:{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"关于" message:@"本软件开发仅作为个人使用，非商业运作，若有雷同，纯属巧合😊" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
            break;
        case 4:{
            
            WebViewController * webView = [[WebViewController alloc]init];
            webView.url = @"http://www.baidu.com";
            [self.navigationController pushViewController:webView animated:YES];
            
            
            
//            [MyNetWorking getDetailDataWithUrl:[NSString stringWithFormat:@"http://luxe.co/api/get_post.json?page_id=%@",self.urlID[indexPath.row]] Success:^(id data) {
//                MyWebViewController *detailVC = [[MyWebViewController alloc] init];
//                detailVC.content = data[@"content"];
//                [self.navigationController pushViewController:detailVC animated:YES];
//            } fail:^(NSString *errorDes) {
//                NSLog(@"%@",errorDes);
//            }];
        }
            break;
        case 1:{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"正在制作ing" message:@"敬请期待" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
            
            //            MyNewsViewController *myNews = [[MyNewsViewController alloc] init];
            //            myNews.tableName = self.urlID[indexPath.row];
            //            [self.navigationController pushViewController:myNews animated:YES];
        }
            break;
        case 2:{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"正在制作ing" message:@"敬请期待" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
            
//            MyNewsViewController *myNews = [[MyNewsViewController alloc] init];
//            myNews.tableName = self.urlID[indexPath.row];
//            [self.navigationController pushViewController:myNews animated:YES];
        }
            break;
        default:
            break;
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
