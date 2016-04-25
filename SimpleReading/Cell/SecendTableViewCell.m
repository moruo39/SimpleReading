//
//  SecendTableViewCell.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/6.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "SecendTableViewCell.h"

@implementation SecendTableViewCell

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
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, Width/2, h-10)];
    
    [self.contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, 5,  Width/2-Width/8, h/2)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:h/8];
//    _titleLabel.center = CGPointMake(Width - Width/8, h/3);
    [self.contentView addSubview:_titleLabel];
    
    _tags_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, CGRectGetMaxY(_titleLabel.frame)+5, Width/2-Width/8, h/3)];
    _tags_titleLabel.textColor = [UIColor grayColor];
    _tags_titleLabel.numberOfLines = 0;
    _tags_titleLabel.font = [UIFont systemFontOfSize:h/9];
    
    //    NSString * str = [model.tags componentsJoinedByString:@" "];
    
    [self.contentView addSubview:_tags_titleLabel];
    
    
//    _excerptLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, CGRectGetMaxY(_tags_titleLabel.frame), Width/2+ Width/10, h/2)];
//    _excerptLable.numberOfLines = 0;
//    _excerptLable.textColor = [UIColor blackColor];
//    _excerptLable.font = [UIFont systemFontOfSize:h/10];
//    [self.contentView addSubview:_excerptLable];
    
}

-(void)setDataWithModel:(SecendViewModel *)model{
    
    //    NSLog(@"%@",model);
    
   [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    _titleLabel.text = model.title;
    
    _excerptLable.text = model.excerpt;
    
    NSMutableString * mStr = [[NSMutableString alloc]init];
    for (NSString * str in model.tags) {
        NSString * s = [NSString stringWithFormat:@" "];
        [mStr appendString:str];
        [mStr appendString:s];
        
    }
    _tags_titleLabel.text = mStr;
    
//    _excerptLable.text = model.excerpt;

    
}

- (void)setDataWithThirdModel:(ThirdViewModel *)model{
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = model.title;
    
    _tags_titleLabel.text = model.subscribe;
    
    
    
}

-(void)setDataWithFourthModel:(FourthViewModel *)model{
    
    
    
//    NSData * data = [[NSData alloc]initWithContentsOfFile:model.icon];
//    _leftImageView.image = [UIImage imageWithData:data];
    
    NSArray *strarray = [model.icon componentsSeparatedByString:@"@"];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:strarray[0]] placeholderImage:[UIImage imageNamed:@"123.jpg"]];
    
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = model.title;
    
    
    
    if ([model.author isEqualToString:@"联合版权"]) {
        _tags_titleLabel.text = model.author;
    }else{
        _tags_titleLabel.text = model.intro;
    }
    
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
