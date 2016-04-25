//
//  JoySecondTableViewCell.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/13.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "JoySecondTableViewCell.h"

@interface JoySecondTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumLabel;


@end


@implementation JoySecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataWithModel:(JoyViewModel *)model{
    
    _titleLabel.text = model.title;
    _titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.bounds.size.height/3.5];
    
    NSArray * array = [model.pic componentsSeparatedByString:@"!"];
    
    [_topImage sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    _sortLabel.text = model.cat;
    
    NSString * str = [NSString stringWithFormat:@"%@阅读",model.readnum];
    _NumLabel.text = str;
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
