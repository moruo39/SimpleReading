//
//  JoyViewModel.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/12.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoyViewModel : NSObject


//{
//    "id": 62310,
//    "urlroute": "juzi://article/detail/native?id=62310",
//    "title": "从伦敦陷落谈起，电影里被摧毁最多次的城市top5都在这里！",
//    "pic": "http://images11.app.happyjuzi.com/news/201604/12/570c54e450627.gif!ac1.nw",
//    "icontype": 8,
//    "publish_time": "10小时前",
//    "type": 1,
//    "readnum": 10928,
//    "replynum": 10,
//    "cat": {
//        "name": "影视"
//    },
//    "author": {
//        "name": "鸭子-橘子编辑"
//    }
//}

//},


@property (nonatomic,retain)NSString * Id;
@property (nonatomic,retain)NSString * title;
@property (nonatomic,retain)NSString * pic;
@property (nonatomic,retain)NSString * publish_time;
@property (nonatomic,retain)NSString * type;
@property (nonatomic,retain)NSString * readnum;
@property (nonatomic,retain)NSString * cat;
@property (nonatomic,retain)NSString * author;


@end
