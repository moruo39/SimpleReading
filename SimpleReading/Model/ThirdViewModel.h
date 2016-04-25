//
//  ThirdViewModel.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/8.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdViewModel : NSObject


//"essay_id": 679,
//"title": "诗与歌的相遇",
//"essay_type": "4",
//"type_name": "言之",
//"subscribe": "在所有艺术形式里，诗与民谣（Folk Music）具有十分相似的特质。在文学领域，诗字数最少，篇幅简短，却又最具深意。在音乐领域，民谣无论在技巧还是配器上往往追求简单，而它的深度在于其冷静的哲思性。",
//"imageurl": "http://7xkszy.com2.z0.glb.qiniucdn.com/library/201604/FpdHibfPt46mMnMT5j08DT1C2nyR.jpg",
//"essay_url": "http://www.luoo.net/m/essay/679",
//"fav": 91,
//"comm": 10,
//"view_count": 2841


@property (nonatomic,retain)NSString * essay_id;
@property (nonatomic,retain)NSString * title;
@property (nonatomic,retain)NSString * essay_type;
@property (nonatomic,retain)NSString * type_name;
@property (nonatomic,retain)NSString * subscribe;
@property (nonatomic,retain)NSString * imageurl;
@property (nonatomic,retain)NSString * essay_url;
@property (nonatomic,retain)NSString * fav;
@property (nonatomic,retain)NSString * comm;
@property (nonatomic,retain)NSString * view_count;





@end
