//
//  SecendViewModel.m
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/6.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "SecendViewModel.h"

@implementation SecendViewModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
        
//        @property (nonatomic,retain)NSString * nid;
//        @property (nonatomic,retain)NSString * title;
//        @property (nonatomic,retain)NSString * excerpt;
//        @property (nonatomic,retain)NSString * thumbnail;
//        
//        @property (nonatomic,retain)NSArray * tags;
        
        
        self.nid = [dict objectForKey:@"id"];
        self.title = [dict objectForKey:@"title"];
        self.excerpt = [dict objectForKey:@"excerpt"];
        self.thumbnail = [dict objectForKey:@"thumbnail"];
        
        NSMutableArray * mArray = [[NSMutableArray alloc]init];
        NSArray * array = [dict objectForKey:@"tags"];
        
        for (NSDictionary * dic in array) {
            NSString * str = [NSString stringWithFormat:@"%@ ",[dic objectForKey:@"name"]];
            [mArray addObject:str];
            
        }
        
        self.tags = mArray;
        
    }
    
    //    NSLog(@"%@",self);
    
    return self;
}

+(instancetype)modelwithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
