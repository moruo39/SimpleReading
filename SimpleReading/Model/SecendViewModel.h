//
//  SecendViewModel.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/6.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecendViewModel : NSObject

@property (nonatomic,retain)NSString * nid;
@property (nonatomic,retain)NSString * title;
@property (nonatomic,retain)NSString * excerpt;
@property (nonatomic,retain)NSString * thumbnail;

@property (nonatomic,retain)NSArray * tags;



- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelwithDict:(NSDictionary *)dict;

@end
