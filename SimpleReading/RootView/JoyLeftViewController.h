//
//  JoyLeftViewController.h
//  LookInfoDemo
//
//  Created by 莫若 on 16/4/14.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JoyLeftViewDelegate <NSObject>

- (void) JoyLeftClickWithChangerNum:(int)num;

@end

@interface JoyLeftViewController : UIViewController


@property (nonatomic,weak)id <JoyLeftViewDelegate> delegate;

@end
