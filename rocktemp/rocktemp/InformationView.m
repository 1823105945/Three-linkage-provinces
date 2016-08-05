//
//  InformationView.m
//  rocktemp
//
//  Created by mhl on 16/7/7.
//  Copyright © 2016年 temp. All rights reserved.
//

#import "InformationView.h"

@implementation InformationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)loadData:(NSDictionary *)dict andCity:(NSString *)city
{
    cityLabel.text = city;
    int typeInt = [[dict objectForKey:@"type"] intValue];
    if (typeInt == 1) {
        typeLabel.text = @"买";
        type2Lable.text = @"【买】";
    }else{
        typeLabel.text = @"卖";
        type2Lable.text = @"【卖】";
    }

    categoryLabel.text = [dict objectForKey:@"category"];
    
    priceLabel.text = [NSString stringWithFormat:@"%@元",[dict objectForKey:@"price"]];
    price2Label.text = [NSString stringWithFormat:@"%@元",[dict objectForKey:@"price"]];
    
    childLabel.text = [dict objectForKey:@"child_category"];
    locationLabel = [dict objectForKey:@"location"];
    telLabel.text = [dict objectForKey:@"tel"];
    contentLabel.text = [NSString stringWithFormat:@"详情:%@",[dict objectForKey:@"content"]];
}


- (IBAction)remove:(id)sender {
    if (self.RemoveView) {
        self.RemoveView();
    }
}


@end
