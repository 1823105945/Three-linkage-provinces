//
//  DownTableViewCell.m
//  rocktemp
//
//  Created by  on 16/7/5.
//  Copyright © 2016年 temp. All rights reserved.
//

#import "DownTableViewCell.h"

@implementation DownTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)loadData:(NSDictionary *)dict
{
    cityLabel.text = [dict objectForKey:@"city"];
    
    int type = [[dict objectForKey:@"type"] intValue];
    if (type == 1) {
        buyingLabel.text = @"买";
    }else{
        buyingLabel.text = @"卖";
    }

    commodityLabel.text = [dict objectForKey:@"child_category"];
    moneyLabel.text = [NSString stringWithFormat:@"%@元",[dict objectForKey:@"price"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
