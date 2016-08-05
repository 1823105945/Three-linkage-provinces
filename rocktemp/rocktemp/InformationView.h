//
//  InformationView.h
//  rocktemp
//
//  Created by mhl on 16/7/7.
//  Copyright © 2016年 temp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationView : UIView
{
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *typeLabel;
    IBOutlet UILabel *type2Lable;
    IBOutlet UILabel *categoryLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *price2Label;
    IBOutlet UILabel *childLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *telLabel;
    IBOutlet UILabel *contentLabel;
}

@property(nonatomic,strong)void (^RemoveView)();


-(void)loadData:(NSDictionary *)dict andCity:(NSString *)city;



@end
