//
//  FilterView.h
//  rocktemp
//
//  Created by yintengxiang on 16/7/6.
//  Copyright © 2016年 temp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewDelegate <NSObject>

- (void)clickDidian:(id)data;
- (void)clickPrice:(id)data;
- (void)clickLeibie:(id)data;
- (void)clickMaimai:(id)data;

@end

@interface FilterView : UIView

@property (nonatomic, weak) id <FilterViewDelegate> delegate;

@end
