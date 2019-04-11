//
//  PlistTableViewController.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "PlistTableViewController.h"
#import "PlistViewCell.h"
#import "StorageViewController.h"

@interface PlistTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.storageType;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.storageType isEqualToString:@"archiver"]) {
        NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"demo.archiver"];
        self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    } else
    
    if ([self.storageType isEqualToString:@"plist"]) {
        
        NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"demo.plist"];
        self.dataSource = [NSMutableArray arrayWithContentsOfFile:plistPath];
    } else {
        self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"person"];
    }
    [self.tableView reloadData];
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlistViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plist"];
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.dic = dic;
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    StorageViewController *storageVC = (StorageViewController *)(segue.destinationViewController);
    if ([segue.identifier isEqualToString:@"plistSelect"]) {
        PlistViewCell *cell = (PlistViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *dic = self.dataSource[indexPath.row];
        NSLog(@"dic = %@", dic);
        storageVC.dic = dic;
        storageVC.index = indexPath.row;
    }
    storageVC.type = self.storageType;
    
}


@end
