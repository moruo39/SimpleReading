//
//  JoyDetailTableViewCell.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/15.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoyDetailModel.h"
#import <WebKit/WebKit.h>


@interface JoyDetailTableViewCell : UITableViewCell

- (void)setDataWithModel:(JoyDetailModel *)model;

@property (nonatomic,retain)UILabel * titleLaber;
@property (nonatomic,retain)UILabel * timeLaber;
@property (nonatomic,retain)UILabel * nameLaber;
@property (nonatomic,retain)UILabel * typeLaber;
@property (nonatomic,retain)UIImageView * titleImage;
@property (nonatomic,retain)WKWebView * webView;




@end
