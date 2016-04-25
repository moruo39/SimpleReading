//
//  FirstTableViewCell.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/24.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    int h = Height/5;
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, Width/4, h-10)];
    [self.contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, 5, Width/2, h/7)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:h/8];
    [self.contentView addSubview:_titleLabel];
    
    _original_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, CGRectGetMaxY(_titleLabel.frame)+5, Width-Width/4, h/7)];
    _original_titleLabel.textColor = [UIColor blackColor];
    _original_titleLabel.font = [UIFont systemFontOfSize:h/9];
    [self.contentView addSubview:_original_titleLabel];
    
    _genresLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, CGRectGetMaxY(_original_titleLabel.frame)+5, Width/2, h/7)];
    _genresLabel.textColor = [UIColor grayColor];
    _genresLabel.font = [UIFont systemFontOfSize:h/9];
    [self.contentView addSubview:_genresLabel];
    
    _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, CGRectGetMaxY(_genresLabel.frame)+5, Width/2, h/7)];
    _yearLabel.textColor = [UIColor grayColor];
    _yearLabel.font = [UIFont systemFontOfSize:h/9];
    [self.contentView addSubview:_yearLabel];
    
    _averageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, CGRectGetMaxY(_yearLabel.frame)+5, Width/2, h/7)];
    _averageLabel.textColor = [UIColor grayColor];
    _averageLabel.font = [UIFont systemFontOfSize:h/9];
    [self.contentView addSubview:_averageLabel];
    
}

-(void)setDataWithModel:(FirstViewModel *)model{
    
//    NSLog(@"%@",model);
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imagesUrl] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    _titleLabel.text = model.title;
    
    _original_titleLabel.text = model.original_title;
    
//    NSString * str = [model.genres componentsJoinedByString:@" "];
//
//    NSMutableString * mStr = [[NSMutableString alloc]init];
//    for (NSString * str in model.genres) {
//        NSString * s = [NSString stringWithFormat:@" "];
//        [mStr appendString:str];
//        [mStr appendString:s];
//        
//    }
    _genresLabel.text = model.genres;
    
    _yearLabel.text = [NSString stringWithFormat:@"年份: %@",model.year];
    
    float number = [model.average floatValue];
    _averageLabel.text = [NSString stringWithFormat:@"评分: %.1f",number];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
