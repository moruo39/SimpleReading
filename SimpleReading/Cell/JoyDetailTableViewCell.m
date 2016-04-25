//
//  JoyDetailTableViewCell.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/15.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "JoyDetailTableViewCell.h"

@implementation JoyDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    
    return self;
}


- (void)createUI{
    
    int h = Height/5;
    
    self.titleLaber = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, Width-10, h/3*2)];
    self.titleLaber.font = [UIFont systemFontOfSize:h/5];
    self.titleLaber.numberOfLines = 0;
    [self.contentView addSubview:self.titleLaber];
    
    self.timeLaber = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    self.timeLaber.textColor = [UIColor grayColor];
    self.timeLaber.font = [UIFont systemFontOfSize:h/10];
    [self.contentView addSubview:self.timeLaber];
    
    self.nameLaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLaber.frame), CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    self.nameLaber.textColor = [UIColor grayColor];
    self.nameLaber.font = [UIFont systemFontOfSize:h/10];
    [self.contentView addSubview:self.nameLaber];
    
    self.typeLaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLaber.frame), CGRectGetMaxY(self.titleLaber.frame), Width/3, h/3-5)];
    self.typeLaber.textColor = [UIColor grayColor];
    self.typeLaber.font = [UIFont systemFontOfSize:h/10];
    [self.contentView addSubview:self.typeLaber];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeLaber.frame), Width, Height/2)];
    [self.contentView addSubview:self.titleImage];
    
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_titleImage.frame), Width, Height - 49) configuration:configuration];
    [self.contentView addSubview:self.webView];
    
    //
    //    self.webView.allowsBackForwardNavigationGestures = YES;
    //    self.webView.UIDelegate = self;
    //    self.webView.navigationDelegate = self;
    
}


- (void)setDataWithModel:(JoyDetailModel *)model{
    
    self.titleLaber.text = model.title;
    self.timeLaber.text = model.publish_time;
    self.nameLaber.text = model.author;
    self.typeLaber.text = model.cat;
    
    NSArray * array = [model.img componentsSeparatedByString:@"!"];
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:array[0]]];
    
//    [self.webView loadHTMLString:model.contents baseURL:nil];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
