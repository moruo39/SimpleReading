//
//  FirstViewModel.h
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstImageModel.h"


@interface FirstViewModel : NSObject

//@property (nonatomic,strong)NSArray * subjects;

@property (nonatomic,retain)NSNumber * nID;
@property (nonatomic,retain)NSNumber * average;
@property (nonatomic,retain)NSString * title;
@property (nonatomic,retain)NSString * original_title;
@property (nonatomic,retain)NSString * year;
@property (nonatomic,retain)NSString * movieId;
@property (nonatomic,retain)NSString * imagesUrl;
@property (nonatomic,retain)NSString * summary;

@property (nonatomic,retain)NSString * genres;
//
@property (nonatomic,retain)NSArray * casts;
//
@property (nonatomic,retain)NSArray * directors;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelwithDict:(NSDictionary *)dict;


@end
