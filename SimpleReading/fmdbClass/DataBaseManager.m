//
//  DataBase.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/26.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "DataBaseManager.h"
#import "FirstViewModel.h"
#import "FirstImageModel.h"

@implementation DataBaseManager

//单例
+(DataBaseManager *)manager{
    static DataBaseManager * manager;
    if (manager == nil) {
        manager = [[DataBaseManager alloc]init];
    }
    return manager;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString * dbPath = [NSString stringWithFormat:@"%@/movie.db",path];
        NSLog(@"%@",dbPath);
        _dataBase = [FMDatabase databaseWithPath:dbPath];
        BOOL b = [_dataBase open];
        
        if (!b) {
            NSLog(@"数据库打开失败");
        }
        
    }
    
    return self;
}


-(void)createDataBase{
    
//    create table if not exists User (Id integer primary key autoincrement,name text,age integer)";
    NSString * sql = @"create table if not exists movie (ID primary key ,title text,genres text,year text,imagers text";
    BOOL b = [_dataBase executeUpdate:sql];
    
    if (!b) {
        NSLog(@"电影表创建失败");
    }
    
    sql = @"create table if not exists MoviePerson (movieID text,personClass text,name text,personId text,imagerUrl text)";
    b = [_dataBase executeUpdate:sql];
    if (!b) {
        NSLog(@"影人信息表创建失败");
    }
}

-(void)insertDatawithArray:(NSArray *)dataArray{
    
    for (int i = 0; i < dataArray.count; i++) {
        
//        电影表数据插入
        FirstViewModel * model = [dataArray objectAtIndex:i];
        NSString * sql = @"insert into Movie (ID,title,genres,year,imagers) values (?,?,?,?,?)";
        BOOL b = [_dataBase executeUpdate:sql,model.movieId,model.title,model.genres,model.year,model.imagesUrl];
        if (!b) {
            NSLog(@"电影表数据插入失败");
        }
        
        
//        影人信息表数据插入
        NSArray * directorsArray = model.directors;
        sql = @"insert into MoviePerson (movieID,personClass,name,personId,imagerUrl) values (?,?,?,?,?)";
        for (FirstImageModel * mo in directorsArray) {
          b = [_dataBase executeUpdate:sql,model.movieId,@"directors",mo.name,mo.nid,mo.large];
            if (!b) {
                NSLog(@"影人信息表directors插入失败");
            }
            
        }
        
        NSArray * castArray = model.casts;
        for (FirstImageModel * mo in castArray) {
            b = [_dataBase executeUpdate:sql,model.movieId,@"casts",mo.name,mo.nid,mo.large];
            if (!b) {
                NSLog(@"影人信息表casts创建失败");
            }
            
        }
        
        
    }
    
}


//-(BOOL)createTableWithName:(NSString *)name andColomArray:(NSArray *)array{
//    //    //        @property (nonatomic,retain)NSString * average;
//    //        @property (nonatomic,retain)NSString * title;
//    //        @property (nonatomic,retain)NSString * original_title;
//    //        @property (nonatomic,retain)NSString * year;
//    //        @property (nonatomic,retain)NSString * movieId;
//    //        @property (nonatomic,retain)NSString * imagesUrl;
//    //
//    //        @property (nonatomic,retain)NSArray * genres;
//    //        //
//    //        @property (nonatomic,retain)NSArray * casts;
//    //        //
//    //        @property (nonatomic,retain)NSArray * directors;
//    
//
//    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
//    
//    //    create table if not exists User (Id integer primary key autoincrement,name text,age integer)";
////    1.创建表时，声明字段类型为二进制 blob
////    NSString *INEditorTableName = @"create table In_Editor(picUrls blob not null)";
//    
//    NSMutableString * sql = [[NSMutableString alloc] initWithFormat:@"create table if not exists %@ (ID integer primary key autoincrement",name];
//    for (NSString * key in dict) {
//        [sql appendFormat:@",%@ %@",key,[dict objectForKey:key]];
//        
//    }
//    [sql appendString:@")"];
//    
//    NSLog(@"%@",sql);
//    
//    BOOL b = [_dataBase executeUpdate:sql];
//    
//    
//    if (b) {
//        NSLog(@"表格创建成功");
//    }
//    return b;
//    
//    
//}

//
//
//#pragma mark 删除制定名称的表格中的数据的方法
//-(BOOL)deletTabelWithName:(NSString *)name{
//    NSString * sql = [NSString stringWithFormat:@"delete from %@",name];
//    BOOL b = [_dataBase executeUpdate:sql];
//    
//    return b;
//}
//
//
//#pragma mark 将制定的数据插入到制定的表格
//-(void)insertDataInto:(NSString *)tableName andData:(NSArray *)dataArray{
//    
//    for (int i = 0 ; i < dataArray.count; i ++) {
//        
//        NewsItem * item = [dataArray objectAtIndex:i];
//        
//        NSMutableString * sql = [[NSMutableString alloc] initWithFormat:@"insert into %@ (name,sname,imageUrl) values (?,?,?)",tableName];
//        BOOL b = [_dataBase  executeUpdate:sql,item.name,item.sName,item.imageUrl];
//        
//        
//        if (b) {
//            NSLog(@"数据插入成功");
//        }
//        
//    }
//}
//
//
-(NSArray *)selectMovieData{
    
    
    NSString * sql = @"select * from Movie";
    FMResultSet * set = [_dataBase executeQuery:sql];
//    
    NSMutableArray * array = [[NSMutableArray alloc] init];
//
    while (set.next) {
        
//        ID primary key ,title text,genres text,year text,imagers text";
        
        FirstViewModel * model = [[FirstViewModel alloc] init];
        model.title = [set stringForColumn:@"title"];
        model.movieId = [set stringForColumn:@"ID"];
        model.genres = [set stringForColumn:@"genres"];
        model.year = [set stringForColumn:@"year"];
        model.imagesUrl = [set stringForColumn:@"imagers"];
        [array addObject:model];
        
        
        model.directors = [self selectWithClass:@"directors" andMovieID:model.movieId];
        model.casts = [self selectWithClass:@"casts" andMovieID:model.movieId];
        
        
    }
    
    
    return array;
}


-(NSArray *)selectWithClass:(NSString *)pClass andMovieID:(NSString *)moveid{
    
    NSMutableArray * mArray = [[NSMutableArray alloc]init];
    NSString * sql = @"select * from MoviePerson where personClass = ? and movieId = ?";
    
    FMResultSet * set = [_dataBase executeQuery:sql];
    while (set.next) {
//        movieID,personClass,name,personId,imagerUrl
        FirstImageModel * model = [[FirstImageModel alloc] init];
        model.name = [set stringForColumn:@"name"];
        model.nid = [set stringForColumn:@"ID"];
        model.large = [set stringForColumn:@"imagerUrl"];
        
        [mArray addObject:model];
        
        
    }
    
    
    
    
    return mArray;
    
}









@end
