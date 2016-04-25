//
//  JoyFirstTableViewCell.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/13.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "JoyFirstTableViewCell.h"

@interface JoyFirstTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sortLabel;


@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@end


@implementation JoyFirstTableViewCell



//
- (void)setDataWithModel:(JoyViewModel *)model{
    
    _titleLabel.text = model.title;
    _titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.bounds.size.height/5];
    
    NSArray * array = [model.pic componentsSeparatedByString:@"!"];
    
    [_leftImage sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    _sortLabel.text = model.cat;
    
    NSString * str = [NSString stringWithFormat:@"%@阅读",model.readnum];
    _numLabel.text = str;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
