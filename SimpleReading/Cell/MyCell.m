//
//  MyCell.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/21.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews

{
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(15, 5, 30, 30)];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.textLabel setFrame:CGRectMake(60, 12, 200, 20)];
}


@end
