//
//  JoyDetailCollectionModel.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/18.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoyDetailCollectionModel : NSObject


//"id": 59784,
//"urlroute": "juzi://article/detail/native?id=59784",
//"title": "《武神赵子龙》林更新、林允儿中韩虐恋，古装剧还能编得这么离谱！",
//"img": "http://images11.app.happyjuzi.com/news/201603/29/56f9f88c63cfc.jpg!ac3.webp"


@property (nonatomic,retain)NSString * Id;
@property (nonatomic,retain)NSString * urlroute;
@property (nonatomic,retain)NSString * title;
@property (nonatomic,retain)NSString * img;
@end
