//
//  FilterView.m
//  rocktemp
//
//  Created by yintengxiang on 16/7/6.
//  Copyright © 2016年 temp. All rights reserved.
//

#import "FilterView.h"
#import "FilterViewCell.h"
#import "UIView+BGFrame.h"

typedef enum : NSInteger {
    didian = 0,
    leibie,
    jiage,
    maimai,
} SelectType;

@interface FilterView () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView3;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UIButton *lButton;
@property (weak, nonatomic) IBOutlet UIButton *pButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIView *btnView;

@property (nonatomic, assign) SelectType selectType;
@property (nonatomic, strong) NSDictionary *areData;
@property (nonatomic, strong) NSDictionary *catData;
@property (nonatomic, strong) NSArray *priceData;
@property (nonatomic, strong) NSArray *maiData;

@property (nonatomic, assign) NSInteger selsectP;
@property (nonatomic, assign) NSInteger selsectCity;
@property (nonatomic, assign) NSInteger selsectCon;
@end

@implementation FilterView

- (void)awakeFromNib
{
    NSLog(@"%f",[[UIScreen mainScreen]bounds].size.width);
    if ([[UIScreen mainScreen]bounds].size.width==320) {
        [self _initButton:self.dButton];
        [self _initButton:self.lButton];
        [self _initButton:self.pButton];
        [self _initButton:self.bButton];
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    self.areData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *catDataPlistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    self.catData = [[NSDictionary alloc] initWithContentsOfFile:catDataPlistPath];
    NSLog(@"%@",_catData);
    
    self.priceData = @[@"500以下",@"500-1000",@"1000-2000",@"2000-3000",@"3000-50000",@"5000以上"];
    
    self.maiData = @[@"买方",@"卖方"];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    [self.tableView1 registerNib:[UINib nibWithNibName:@"FilterViewCell" bundle:nil] forCellReuseIdentifier:@"FilterViewCell"];
    [self.tableView2 registerNib:[UINib nibWithNibName:@"FilterViewCell" bundle:nil] forCellReuseIdentifier:@"FilterViewCell"];
    [self.tableView3 registerNib:[UINib nibWithNibName:@"FilterViewCell" bundle:nil] forCellReuseIdentifier:@"FilterViewCell"];
}

-(void)_initButton:(UIButton *)button{
    button.imageEdgeInsets=UIEdgeInsetsMake(0, 50, 0, 0);
    button.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 30);
}


- (void)loadTableView:(NSInteger)number
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSArray *arr = @[self.tableView1,self.tableView2,self.tableView3];
    
    
    self.selsectP = 0;
    self.selsectCity = 0;
    self.selsectCon = 0;
    
    for (int i = 0; i < arr.count; i ++) {
        UITableView *tbv = (UITableView *)[arr objectAtIndex:i];
        tbv.hidden = YES;
        [tbv reloadData];
    }
    
    for (int i = 0; i < number; i ++) {
       UITableView *tbv = (UITableView *)[arr objectAtIndex:i];
        tbv.hidden = NO;
        tbv.width = width/number;
    }

    self.tableView2.left = self.tableView1.right;
    self.tableView3.left = self.tableView2.right;
    
}

#pragma mark - click
- (IBAction)clickFilterButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (button.selected) {
        [self clickHiddenBtn:nil];
        return;
    }
    
    self.selectType = button.tag;
    
    [[self.btnView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            if (btn.tag == button.tag) {
                button.selected = YES;
            }else {
                btn.selected = NO;
            }
        }
    }];

    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.5 animations:^{
        wself.height = [UIScreen mainScreen].bounds.size.height;
    } completion:^(BOOL finished) {
        
    }];
    
    switch (button.tag) {
        case 0:
            [self loadTableView:3];
            break;
        case 1:
            [self loadTableView:2];
            break;
        case 2:
        case 3:
            [self loadTableView:1];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)clickHiddenBtn:(id)sender
{
    [[self.btnView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            btn.selected = NO;
        }
    }];
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.5 animations:^{
        wself.height = 44;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //地点
    if (self.selectType == 0 && self.tableView1 == tableView) {
        return [self.areData count];
    }
    if (self.selectType == 0 && self.tableView2 == tableView) {
        return [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][[[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject]] allKeys] count];
    }
    if (self.selectType == 0 && self.tableView3 == tableView) {
        
        NSString *key1 = [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject];
        
        NSString *key = [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][[[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject]][[NSString stringWithFormat:@"%zd",self.selsectCity]] allKeys] firstObject];
        
        return [self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][key1][[NSString stringWithFormat:@"%zd",self.selsectCity]][key] count];
        
    }
    
    //类别
    if (self.selectType == 1 && self.tableView1 == tableView) {
        return [self.catData count];
    }
    if (self.selectType == 1 && self.tableView2 == tableView) {
        return [[[self.catData[[NSString stringWithFormat:@"%zd",self.selsectP]] allValues]firstObject]  count];
    }

    //价格
    if (self.selectType == 2 && self.tableView1 == tableView) {
        return [self.priceData count];
    }
    
    //买卖
    if (self.selectType == 3 && self.tableView1 == tableView) {
        return [self.maiData count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterViewCell *cell = (FilterViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FilterViewCell" forIndexPath:indexPath];
    //地点的cell
    
    if (self.selectType == 0 && self.tableView1 == tableView) {
        cell.titleLabel.text = [[self.areData[[NSString stringWithFormat:@"%zd",indexPath.row]] allKeys] firstObject];
    }
    if (self.selectType == 0 && self.tableView2 == tableView) {
        cell.titleLabel.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
        cell.titleLabel.text =[[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][[[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject]][[NSString stringWithFormat:@"%zd",indexPath.row]] allKeys] firstObject];
        
    }
    if (self.selectType == 0 && self.tableView3 == tableView) {
        
       NSString *key1 = [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject];
        cell.titleLabel.backgroundColor=[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
       NSString *key = [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][[[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject]][[NSString stringWithFormat:@"%zd",self.selsectCity]] allKeys] firstObject];

        
        
        cell.titleLabel.text =  [self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][key1][[NSString stringWithFormat:@"%zd",self.selsectCity]][key] objectAtIndex:indexPath.row];
    }
    
    //类别的cell
    if (self.selectType == 1 && self.tableView1 == tableView) {
        cell.titleLabel.text = [[self.catData[[NSString stringWithFormat:@"%zd",indexPath.row]] allKeys] firstObject];
    }
    if (self.selectType == 1 && self.tableView2 == tableView) {
        cell.titleLabel.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
        cell.titleLabel.text = [[[self.catData[[NSString stringWithFormat:@"%zd",self.selsectP]] allValues] firstObject] objectAtIndex:indexPath.row];
        
    }
    
    //价格的cell
    if (self.selectType == 2 && self.tableView1 == tableView) {
        
        cell.titleLabel.text = [self.priceData objectAtIndex:indexPath.row];
        
    }
    //买卖的cell
    if (self.selectType == 3 && self.tableView1 == tableView) {
        
        cell.titleLabel.text = [self.maiData objectAtIndex:indexPath.row];
        
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView1 == tableView) {
        self.selsectP = indexPath.row;
        
        self.selsectCity = 0;
        self.selsectCon = 0;
        
        [self.tableView2 reloadData];
        [self.tableView3 reloadData];
    }
    if (self.tableView2 == tableView) {
        self.selsectCity = indexPath.row;
        
        self.selsectCon = 0;
        
        [self.tableView3 reloadData];
    }
    if (self.tableView3 == tableView) {
        self.selsectCon = indexPath.row;
    }
    NSLog(@"%ld",(long)self.selectType);
    if (self.tableView1 == tableView && self.selectType == jiage) {
        if ([self.delegate respondsToSelector:@selector(clickPrice:)]) {
            NSLog(@"%@", self.priceData);
            [self clickHiddenBtn:nil];
            [self.pButton setTitle:[self.priceData objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self.delegate clickPrice:[self.priceData objectAtIndex:indexPath.row]];
        }
    }
    if (self.tableView1 == tableView && self.selectType == maimai) {
        if ([self.delegate respondsToSelector:@selector(clickMaimai:)]) {
            NSLog(@"%@", self.maiData);
            [self clickHiddenBtn:nil];
            [self.bButton setTitle:[self.maiData objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self.delegate clickMaimai:[self.maiData objectAtIndex:indexPath.row]];
        }
    }
    if (self.tableView2 == tableView && self.selectType == leibie) {
        if ([self.delegate respondsToSelector:@selector(clickLeibie:)]) {
            NSString *key=[[self.catData[[NSString stringWithFormat:@"%zd",indexPath.row]] allKeys] firstObject];
            NSString *value=[[[self.catData[[NSString stringWithFormat:@"%zd",self.selsectP]] allValues] firstObject] objectAtIndex:indexPath.row];
            [self clickHiddenBtn:nil];
            NSLog(@"%@   %@",key,value);
            [self.lButton setTitle:value forState:UIControlStateNormal];
            [self.delegate clickLeibie:[NSString stringWithFormat:@"%@%@",key,value]];
        }
    }
    if (self.tableView3 == tableView && self.selectType == didian) {
        if ([self.delegate respondsToSelector:@selector(clickDidian:)]) {
            [self clickHiddenBtn:nil];
            NSString *key1 = [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject];
            
            NSString *key = [[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][[[self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]] allKeys] firstObject]][[NSString stringWithFormat:@"%zd",self.selsectCity]] allKeys] firstObject];
            
            NSString *acer =  [self.areData[[NSString stringWithFormat:@"%zd",self.selsectP]][key1][[NSString stringWithFormat:@"%zd",self.selsectCity]][key] objectAtIndex:indexPath.row];
//传递省市区
            [self.dButton setTitle:acer forState:UIControlStateNormal];
            [self.delegate clickDidian:[NSString stringWithFormat:@"%@%@%@",key1,key,acer]];
        }
    }
    
    
}
@end
