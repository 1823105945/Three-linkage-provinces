//
//  DownTableViewCell.h
//  rocktemp
//
//  Created by  on 16/7/5.
//  Copyright © 2016年 temp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownTableViewCell : UITableViewCell
{
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *buyingLabel;
    IBOutlet UILabel *commodityLabel;
    IBOutlet UILabel *moneyLabel;
}

-(void)loadData:(NSDictionary *)dict;



@end
