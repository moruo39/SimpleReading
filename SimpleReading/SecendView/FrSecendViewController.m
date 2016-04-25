//
//  FrSecendViewController.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/24.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "FrSecendViewController.h"


@interface FrSecendViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,retain)NSMutableArray * imageArray;
//@property (nonatomic,retain)NSMutableArray * nameArray;

@property (nonatomic,retain)UIScrollView * scrollView;

@property (nonatomic,retain)UIImageView * bgImageView;
@property (nonatomic,retain)UIImageView * titleImageView;

@property (nonatomic,retain)UILabel * titleLaber;
@property (nonatomic,retain)UILabel * yearLabel;
@property (nonatomic,retain)UILabel * genresLabel;
@property (nonatomic,retain)UILabel * averageLabel;

@property (nonatomic,retain)NSString * url;
@property (nonatomic,retain)NSString * detailText;

@property (nonatomic,retain)UITableView * tableView;


@property (nonatomic, retain) FirstImageModel * imageModel;

@property (nonatomic,retain)UITextView * textView;

//@property (nonatomic,)

@end

@implementation FrSecendViewController

#pragma mark 懒加载

-(UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height/2)];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:_model.imagesUrl]];
//    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.userInteractionEnabled = YES;
    
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, CGRectGetMinY(_bgImageView.frame), Width, Height/2);
    effectView.alpha = 1;
    [_bgImageView addSubview:effectView];
    
    [_tableView addSubview:_bgImageView];
    }
    
    return _bgImageView;
    
}

-(UIImageView *)titleImageView{
    
    if (!_titleImageView) {
        
        int w = self.bgImageView.bounds.size.width;
        int h = self.bgImageView.bounds.size.height;
        
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, w/2, h-h/10)];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:_model.imagesUrl]];
//        _bgImageView.userInteractionEnabled = YES;
        _titleImageView.center = _bgImageView.center;
//        添加阴影
        _titleImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _titleImageView.layer.shadowOffset = CGSizeMake(2,2); //偏移值
        _titleImageView.layer.shadowOpacity = 0.5; //透明度
        _titleImageView.layer.shadowRadius = 2.0;//半径

        
        [_bgImageView addSubview:_titleImageView];
        
    }
    
    return _titleImageView;
    
}

- (UILabel *)titleLaber{
    if (!_titleLaber) {
        _titleLaber = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_bgImageView.frame), Width/2, Height/5/7)];
        _titleLaber.textColor = [UIColor blackColor];
        _titleLaber.font = [UIFont systemFontOfSize:Height/5/8];
        _titleLaber.text = _model.title;
        
        [_tableView addSubview:_titleLaber];
    }
    
    return _titleLaber;
}

- (UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLaber.frame), CGRectGetMaxY(_bgImageView.frame), Width/2-10, Height/5/7)];
        _yearLabel.textColor = [UIColor grayColor];
        _yearLabel.font = [UIFont systemFontOfSize:Height/5/9];
        _yearLabel.text = [NSString stringWithFormat:@"年份: %@",_model.year];
        
        [_tableView addSubview:_yearLabel];
    }
    
    return _titleLaber;
}


- (UILabel *)genresLabel{
    if (!_genresLabel) {
        _genresLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_titleLaber.frame), Width/2, Height/5/7)];
        _genresLabel.textColor = [UIColor grayColor];
        _genresLabel.font = [UIFont systemFontOfSize:Height/5/9];
        _genresLabel.text = _model.genres;
        
        [_tableView addSubview:_genresLabel];
    }
    
    return _titleLaber;
}

- (UILabel *)averageLabel{
    if (!_averageLabel) {
        _averageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_genresLabel.frame), CGRectGetMaxY(_titleLaber.frame), Width/2-10, Height/5/7)];
        _averageLabel.textColor = [UIColor grayColor];
        _averageLabel.font = [UIFont systemFontOfSize:Height/5/9];
        
        float number = [_model.average floatValue];
        _averageLabel.text = [NSString stringWithFormat:@"评分: %.1f",number];
        
        [_tableView addSubview:_averageLabel];
    }
    
    return _titleLaber;
}



-(NSMutableArray *)imageArray{
    
    if (!_imageArray) {
    _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}

//-(NSMutableArray *)nameArray{
//    _nameArray = [[NSMutableArray alloc]init];
//    return _nameArray;
//}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_averageLabel.frame), Width,Height/4)];
    
//    _scrollView.contentSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)
    _scrollView.delegate = self;
    //分页属性   水平和高度的指示器
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_tableView addSubview:_scrollView];
    }
    return _scrollView;
}


-(UITextView *)textView{
    if (!_textView) {
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_scrollView.frame)+15, Width-10, Height/3+10)];
//        _textView.center = CGPointMake(Width, Height/2);
//        禁编写
        _textView.editable = NO;
        _textView.font = [UIFont systemFontOfSize:Height/5/7];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor whiteColor];
        [_tableView addSubview:_textView];
        
        
    }
    
    return _textView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = Height + Height/3;
        
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}



#pragma mark viewDidLoad

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = _model.title;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    [self getData];
    
}

#pragma mark creatUI

- (void)createUI{
    
    [self tableView];
    [self bgImageView];
    [self titleImageView];
    [self titleLaber];
    [self yearLabel];
    [self genresLabel];
    [self averageLabel];
    
    [self scrollView];
    [self textView];
    
}




#pragma mark tabelView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    
    
    
    return cell;
    
    
}


#pragma mark getData

- (void)getData{
    
    self.url = [NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@",_model.nID];

    [MyNetWorking getFirstViewDatawithUrl:self.url Success:^(id Data) {
        NSString * str = [Data objectForKey:@"summary"];
//        NSLog(@"%@",_detailText);
        _detailText = [NSString stringWithFormat:@"详情:\n     %@",str];
        _textView.text = _detailText;

        
    } Fail:^(NSString *ErrorDer) {
        NSLog(@"%@",ErrorDer);
    }];
    
    
    NSArray * castsArray = _model.casts;
    NSArray * directorsArray = _model.directors;
    [self imageArray];
    
    [_imageArray addObjectsFromArray:castsArray];
    [_imageArray addObjectsFromArray:directorsArray];
    
    [self createScollorView];
}

- (void)createScollorView{
    // 添加视图
    [self scrollView];
    
    int w = Width/3;
    int h = Height/4;
    
    _scrollView.contentSize = CGSizeMake(_imageArray.count * w + _imageArray.count * 5, h);
    
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(w * i+ i *5, 0, w, h-10)];
        FirstImageModel * model = _imageArray[i];
        
        NSString * strImage = model.large;
        NSURL * url = [NSURL URLWithString:strImage];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"123.jpg"]];
        
        UILabel * nameLb = [[UILabel alloc]initWithFrame:CGRectMake(w * i + i * 5, CGRectGetMaxY(imageView.frame), w, 10)];
        nameLb.textAlignment = NSTextAlignmentCenter;
        nameLb.textColor = [UIColor grayColor];
        nameLb.font = [UIFont systemFontOfSize:9];
        nameLb.text = model.name;
        
        [_scrollView addSubview:imageView];
        [_scrollView addSubview:nameLb];
        
        
    }
    
    [_tableView reloadData];
    
}






#pragma mark colletiontionView



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
