//
//  FirstViewModel.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "FirstViewModel.h"

@implementation FirstViewModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
//        @property (nonatomic,retain)NSString * average;
//        @property (nonatomic,retain)NSString * title;
//        @property (nonatomic,retain)NSString * original_title;
//        @property (nonatomic,retain)NSString * year;
//        @property (nonatomic,retain)NSString * movieId;
//        @property (nonatomic,retain)NSString * imagesUrl;
//        
//        @property (nonatomic,retain)NSArray * genres;
//        //
//        @property (nonatomic,retain)NSArray * casts;
//        //
//        @property (nonatomic,retain)NSArray * directors;
        
        
        self.genres = [[dict objectForKey:@"genres"] componentsJoinedByString:@","];
        self.nID = [dict objectForKey:@"id"];
        
//        NSLog(@"%@",self.nID);

        
        self.title = [dict objectForKey:@"title"];
        self.movieId = [dict objectForKey:@"id"];
        self.original_title = [dict objectForKey:@"original_title"];
        self.year = [dict objectForKey:@"year"];
        
//        self.summary = [dict objectForKey:@"summary"];
        
        self.average = [dict objectForKey:@"rating"][@"average"];
        self.imagesUrl = [dict objectForKey:@"images"][@"large"];
        
        NSMutableArray * marry1 = [[NSMutableArray alloc]init];
        NSArray * array1= [dict objectForKey:@"casts"];
        for (NSDictionary * casts in array1) {
            FirstImageModel * model1 = [[FirstImageModel alloc]init];
            model1.name = [casts objectForKey:@"name"];
            model1.nid = [casts objectForKey:@"id"];
            model1.alt = [casts objectForKey:@"alt"];
            model1.large = [[casts objectForKey:@"avatars"] objectForKey:@"large"];

            [marry1 addObject:model1];
        }
        self.casts = marry1;
        
        NSMutableArray * marry2 = [[NSMutableArray alloc]init];
        NSArray * array2= [dict objectForKey:@"directors"];
        for (NSDictionary * directors in array2) {
            FirstImageModel * model2 = [[FirstImageModel alloc]init];
            model2.name = [directors objectForKey:@"name"];
            model2.nid = [directors objectForKey:@"id"];
            model2.alt = [directors objectForKey:@"alt"];
            model2.large = [[directors objectForKey:@"avatars"] objectForKey:@"large"];
            
            [marry2 addObject:model2];
        }
        self.directors = marry2;
        
        
        
    }
    
//    NSLog(@"%@",self);
    
    return self;
}

+(instancetype)modelwithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
