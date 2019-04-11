//
//  SqliteViewController.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/9.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "SqliteViewController.h"
#import "DBSqlite.h"
#import "StorageViewController.h"
#import "FMDBManager.h"

@interface SqliteViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SqliteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStyleDone target:self action:@selector(delete:)];
    UIBarButtonItem *insertItem = [[UIBarButtonItem alloc] initWithTitle:@"insert" style:UIBarButtonItemStyleDone target:self action:@selector(insert:)];
    self.navigationItem.rightBarButtonItems = @[deleteItem, insertItem];
    
//
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.dataSource = [[DBSqlite shareManager] searchData];
    
    [self reloadData];
}

- (void)reloadData {
    __weak __typeof(&*self) weakSelf = self;
    [FMDBManager quaryDataWithCompletion:^(NSArray *arr) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)delete:(id)sender {
    [FMDBManager dropTable];
    [self reloadData];
}

- (void)insert:(id)sender {
//    [[DBSqlite shareManager] insertData];
    for (int i = 0; i < 10; i++) {
        
        int age = arc4random() % 10000;
        NSString *name = [NSString stringWithFormat:@"sqlite %d", age];
        NSString *sex = age % 2 ? @"M" : @"F";
        NSString *email = [NSString stringWithFormat:@"%@%@", name, @"@email.com"];
        NSDictionary *dic = @{@"name" : name, @"age" : @(age), @"sex" : sex, @"email" : email};
        
        [FMDBManager insertDataWithInfo:dic];
    }
    
    [self reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    cell.textLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    cell.textLabel.text = [NSString stringWithFormat:@"name: %@, age: %@", dic[@"name"], dic[@"age"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"sex: %@, email: %@", dic[@"sex"], dic[@"email"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StorageViewController *svc = [sb instantiateViewControllerWithIdentifier:@"storage"];
    svc.dic = dic;
    svc.index = indexPath.row;
    [self.navigationController pushViewController:svc animated:YES];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak __typeof(&*self) weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *dic = self.dataSource[indexPath.row];
        
//        [[DBSqlite shareManager] deleteDataWithDic:dic];
        [FMDBManager deleteDataWithDic:dic];
        [weakSelf.dataSource removeObject:dic];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    UITableViewRowAction *insert = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"添加" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [[DBSqlite shareManager] insertData];
//        weakSelf.dataSource = [[DBSqlite shareManager] searchData];
        int age = arc4random() % 10000;
        NSString *name = [NSString stringWithFormat:@"sqlite %d", age];
        NSString *sex = age % 2 ? @"M" : @"F";
        NSString *email = [NSString stringWithFormat:@"%@%@", name, @"@email.com"];
        NSDictionary *dic = @{@"name" : name, @"age" : @(age), @"sex" : sex, @"email" : email};
        [FMDBManager insertDataWithInfo:dic];
        [FMDBManager quaryDataWithCompletion:^(NSArray *arr) {
            weakSelf.dataSource = [NSMutableArray arrayWithArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }];
    }];
    return @[delete, insert];
}


@end
