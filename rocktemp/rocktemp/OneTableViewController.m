//
//  OneTableViewController.m
//  rocktemp
//
//  Created by  on 16/7/5.
//  Copyright © 2016年 temp. All rights reserved.
//

#import "OneTableViewController.h"
#import "UpTableViewCell.h"
#import "DownTableViewCell.h"
#import "InformationView.h"
#import "FilterView.h"


@interface OneTableViewController ()<FilterViewDelegate>
{
    NSMutableArray *oneArray;
    NSDictionary *oneDict;
    InformationView *informationView;
    
    NSString *cityStr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation OneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FilterView *fView = (FilterView *)[[[NSBundle mainBundle] loadNibNamed:@"FilterView" owner:[FilterView class] options:nil] lastObject];
    fView.backgroundColor=[UIColor clearColor];
    fView.delegate = self;
    fView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44);
    [self.view addSubview:fView];
    oneArray = [NSMutableArray arrayWithCapacity:1];
    [self.tableView registerClass:[DownTableViewCell class]  forCellReuseIdentifier:@"DownCell"];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return oneArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell loadData:[oneArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    cityStr = [[oneArray objectAtIndex:indexPath.row] objectForKey:@"city"];
}




#pragma mark - FilterViewDelegate
- (void)clickDidian:(id)data
{
    NSLog(@"%@",data);
    //省市区事件
}
- (void)clickPrice:(id)data
{
    NSLog(@"%@",data);
    //价格事件
}
- (void)clickLeibie:(id)data
{
    NSLog(@"%@",data);
    //类别事件
}
- (void)clickMaimai:(id)data
{
    NSLog(@"%@",data);
    //买卖事件
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
