//
//  HomeViewController.m
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "HomeViewController.h"
#import "UserDB.h"
#import "EditViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //创建表
    //[[UserDB sharedDB] createTable];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"增加" style:UIBarButtonItemStylePlain target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self reloadData];
}

- (void)reloadData
{
    self.data = [[UserDB sharedDB] selectTable];
    [self.tableView reloadData];
}


- (void)addAction
{
    EditViewController *editCtrl = [[EditViewController alloc] init];
    [self.navigationController pushViewController:editCtrl animated:YES];
}

#pragma mark  -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UserModel *user = self.data[indexPath.row];
    NSString *showText = [NSString stringWithFormat:@"%@,%@",user.name,user.email];
    cell.textLabel.text = showText;
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
