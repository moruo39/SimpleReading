//
//  FirstTableViewCell.h
//  DoubanMovie
//
//  Created by 莫若 on 16/3/24.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewModel.h"

@interface FirstTableViewCell : UITableViewCell

//self.genres = [dict objectForKey:@"genres"];
//self.title = [dict objectForKey:@"title"];
//self.nid = [dict objectForKey:@"id"];
//self.original_title = [dict objectForKey:@"original_title"];
//self.year = [dict objectForKey:@"year"];
//self.average = [dict objectForKey:@"rating"][@"average"];
//self.images = [dict objectForKey:@"images"][@"large"];


@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * genresLabel;
@property (nonatomic,strong)UILabel * original_titleLabel;
@property (nonatomic,strong)UILabel * yearLabel;
@property (nonatomic,strong)UILabel * averageLabel;

@property (nonatomic,strong)UIImageView * leftImageView;

- (void)setDataWithModel:(FirstViewModel *)model;


@end
