//
//  MyNetWorking.m
//  DoubanMovie
//
//  Created by 莫若 on 16/3/23.
//  Copyright © 2016年 cat. All rights reserved.
//

#import "MyNetWorking.h"

@implementation MyNetWorking



#pragma mark JoyView

+ (void)getJoyViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail{
    
//    NSDictionary * parmams = {@"":@"",}
    
    [self startGetDataWithUrl:url Params:nil Success:success Fail:fail];

}

+ (void)getJoyDetailViewDatawithUrl:(NSString *)url andNum:(NSString *)num Success:(SuccessBlock)success Fail:(FailBlock)fail{
    
//    ?id=%@&net=wifi&pf=ios&res=375x667&uid=3960959803157179&ver=2.9.2
    
    NSDictionary * parmams = @{@"id": num, @"net":@"wifi",@"pf":@"ios",@"res":@"375x667",@"uid":@"3960959803157179",@"ver":@"2.9.2"};

    [self startGetDataWithUrl:url Params:parmams Success:success Fail:fail];

    
}



#pragma mark ClassView


//thirdVC
+ (void)getThirdViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail{
    
    [self startGetDataWithUrl:url Params:nil Success:success Fail:fail];
}



//SecendVC
+ (void)getSecendViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail{
    
    [self startGetDataWithUrl:url Params:nil Success:success Fail:fail];

}



//firstVC
+ (void)getFirstViewDatawithUrl:(NSString *)url Success:(SuccessBlock)success Fail:(FailBlock)fail{
    
    [self startGetDataWithUrl:url Params:nil Success:success Fail:fail];
}

#pragma mark 获取数据


+ (void)startGetDataWithUrl:(NSString *)url Params:(NSDictionary *)params Success:(SuccessBlock)successBlock Fail:(FailBlock)failBlock{
    
    AFHTTPRequestOperationManager * manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    [manage GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        successBlock(dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error.localizedDescription);
//        localizedDescription
    }];
    
    
    
}

@end
