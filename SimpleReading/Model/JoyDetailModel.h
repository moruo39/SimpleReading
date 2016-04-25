//
//  JoyDetailModel.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/15.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoyDetailModel : NSObject

//"id": 61167,
//"title": "《武神赵子龙》的错误笑死人了，编剧你好好读读历史成吗？",
//"iskol": false,
//"cat": {
//    "id": 59,
//    "name": "影视",
//    "urlroute": "juzi://article/list/category?id=59&name=%E5%BD%B1%E8%A7%86"
//},
//"author": {
//    "id": 425,
//    "username": "Hana-橘子编辑 ",
//    "urlroute": "juzi://article/list/author?id=425&name=Hana-%E6%A9%98%E5%AD%90%E7%BC%96%E8%BE%91+",
//    "avator": "http://images11.app.happyjuzi.com/portrait/565d126cb4c97.jpg!up1.webp"
//},
//"txtlead": "《武神赵子龙》的错误笑死人了，编剧你好好读读历史成吗？",
//"img": "http://images11.app.happyjuzi.com/news/201604/05/570337a293c63.jpg!wh1",
//"shareurl": "http://a.happyjuzi.com/2016/04/61167.html?d_source=mobile",
//"publish_time": "2016-04-05 18:11"
//},
//"contents":



@property (nonatomic,retain)NSString * cat;
@property (nonatomic,retain)NSString * title;
@property (nonatomic,retain)NSString * author;
@property (nonatomic,retain)NSString * img;
@property (nonatomic,retain)NSString * type;
@property (nonatomic,retain)NSString * shareurl;
@property (nonatomic,retain)NSNumber * publish_time;
@property (nonatomic,retain)NSString * contents;

@property (nonatomic,retain)NSArray * recommend;
@property (nonatomic,retain)NSArray * resources;



@end
