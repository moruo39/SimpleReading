//
//  SecendTableViewCell.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/6.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecendViewModel.h"
#import "ThirdViewModel.h"
#import "FourthViewModel.h"

@interface SecendTableViewCell : UITableViewCell


@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * tags_titleLabel;
@property (nonatomic,strong)UILabel * excerptLable;

@property (nonatomic,strong)UIImageView * leftImageView;

- (void)setDataWithModel:(SecendViewModel *)model;

- (void)setDataWithThirdModel:(ThirdViewModel *)model;

- (void)setDataWithFourthModel:(FourthViewModel *)model;

@end
