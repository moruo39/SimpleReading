//
//  MyNetWorking.h
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id Data);
typedef void(^FailBlock)(NSString * ErrorDer);


@interface MyNetWorking : NSObject


#pragma mark JoyView

+ (void)getJoyViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail;

+ (void)getJoyDetailViewDatawithUrl:(NSString *)url andNum:(NSString *)num Success:(SuccessBlock)success Fail:(FailBlock)fail;


#pragma mark ClassView

//firstVC
+ (void)getFirstViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail;

//secendVC
+ (void)getSecendViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail;

//thirdVC
+ (void)getThirdViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail;



@end
