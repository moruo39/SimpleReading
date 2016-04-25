//
//  DataBase.h
//  DoubanMovie
//
//  Created by 莫若 on 16/3/26.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

@property (nonatomic,retain)FMDatabase * dataBase;

#pragma mark 创建数据库的方法
+(DataBaseManager *)manager;

-(instancetype)init;

#pragma mark 创建表格的方法

-(void)createDataBase;
//
//
//-(BOOL)createTableWithName:(NSString *)name andColom:(NSDictionary *)dict;
//
//
//#pragma mark 删除制定名称的表格中的数据的方法
//-(BOOL)deletTabelWithName:(NSString *)name;
//
//
#pragma mark 将制定的数据插入到制定的表格
-(void)insertDatawithArray:(NSArray *)dataArray;
//
//
//
#pragma mark 查询数据
-(NSArray *)selectMovieData;


@end
